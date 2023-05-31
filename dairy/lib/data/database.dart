import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'diary.dart';

class DatabaseHelper{
  static final _databaseName = "diary.db";
  static final _databaseVersion = 1;
  static final diaryTable = "diary";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async{
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $diaryTable (
      date INTEGER DEFAULT 0,
      title String,
      memo String,
      image String,
      status INTEGER DEFAULT 0)
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async{}
  // diary 입력, 수정, 불러오

  Future<int> insertDiary(Diary diary) async{
    Database db = await instance.database;

    List<Diary> d = await getDiaryByDate(diary.date);

    if(d.isEmpty){
      // 새로 추가
      Map<String, dynamic> row={
        "title":diary.title,
        "date": diary.date,
        "memo":diary.memo,
        "status":diary.status,
        "image":diary.image
      };

      // return await db.close();
      // return await db.execute('''drop table diary''');
      return await db.insert(diaryTable, row);
    }else{
      Map<String, dynamic> row={
        "title":diary.title,
        "date": diary.date,
        "memo":diary.memo,
        "status":diary.status,
        "image":diary.image
      };
      return await db.update(diaryTable, row, where: "date = ?", whereArgs: [diary.date] );
    }
  }

  Future<List<Diary>> getAllDiary() async{
    Database db = await instance.database;
    List<Diary> diarys = [];

    var queries = await db.query(diaryTable);

    for (var q in queries){
      diarys.add(Diary(
          title: q["title"],
          date: q["date"],
          memo: q["memo"],
          status: q["status"],
          image: q["image"]
      ));
    }

    return diarys;
  }

  Future<List<Diary>> getDiaryByDate(int date) async {
    Database db = await instance.database;
    List<Diary> diarys = [];

    var queries = await db.query(diaryTable, where: "date = ?", whereArgs: [date]);

    for(var q in queries){
      diarys.add(Diary(
        title: q["title"],
        date: q["date"],
        image: q["image"],
        status: q["status"],
        memo: q["memo"],
      ));
    }

    return diarys;
  }

}