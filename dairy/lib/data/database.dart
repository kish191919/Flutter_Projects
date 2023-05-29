import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dairy.dart';

class DatabaseHelper{
  static final _databaseName = "dairy.db";
  static final _databaseVersion = 1;
  static final dairyTable = "dairy";

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
      CREATE TABLE IF NOT EXISTS $dairyTable (
      date INTEGER DEFAULT 0,
      title String,
      memo String,
      image String,
      status INTEGER DEFAULT 0)
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async{}
  // dairy 입력, 수정, 불러오

  Future<int> insertDairy(Dairy dairy) async{
    Database db = await instance.database;

    List<Dairy> d = await getDairyByDate(dairy.date);

    if(d.isEmpty){
      // 새로 추가
      Map<String, dynamic> row={
        "title":dairy.title,
        "date": dairy.date,
        "memo":dairy.memo,
        "status":dairy.status,
        "image":dairy.image
      };

      // return await db.close();
      // return await db.execute('''drop table dairy''');
      return await db.insert(dairyTable, row);
    }else{
      Map<String, dynamic> row={
        "title":dairy.title,
        "date": dairy.date,
        "memo":dairy.memo,
        "status":dairy.status,
        "image":dairy.image
      };
      return await db.update(dairyTable, row, where: "date = ?", whereArgs: [dairy.date] );
    }
  }

  Future<List<Dairy>> getAllDairy() async{
    Database db = await instance.database;
    List<Dairy> dairys = [];

    var queries = await db.query(dairyTable);

    for (var q in queries){
      dairys.add(Dairy(
          title: q["title"],
          date: q["date"],
          memo: q["memo"],
          status: q["status"],
          image: q["image"]
      ));
    }

    return dairys;
  }

  Future<List<Dairy>> getDairyByDate(int date) async{
    Database db = await instance.database;
    List<Dairy> dairys = [];

    var queries = await db.query(dairyTable, where: "date = ?", whereArgs: [date]);
    for (var q in queries){
      dairys.add(Dairy(
          title: q["title"],
          date: q["date"],
          memo: q["memo"],
          status: q["status"],
          image: q["image"]
      ));
    }
    return dairys;
  }

}