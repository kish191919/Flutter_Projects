
import 'package:sqflite/sqflite.dart';
import 'package:todo7/data/todo.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final _databaseName = "todo7.db";
  static final _databaseVersion = 1;
  static final todoTable = "todo7";

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
      CREATE TABLE IF NOT EXISTS $todoTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER DEFAULT 0,
      title String,
      memo String,
      done INTEGER DEFAULT 0,
      color INTEGER,
      category String)
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async{}
  // todo 입력, 수정, 불러오

  Future<int> insertTodo(Todo todo) async{
    Database db = await instance.database;

    if(todo.id == null){
      // 새로 추가
      Map<String, dynamic> row={
        "title":todo.title,
        "date": todo.date,
        "memo":todo.memo,
        "done":todo.done,
        "color": todo.color,
        "category":todo.category
      };

      // return await db.close();
      // return await db.execute('''drop table todo''');
      return await db.insert(todoTable, row);
    }else{
      Map<String, dynamic> row={
        "title":todo.title,
        "date": todo.date,
        "memo":todo.memo,
        "done":todo.done,
        "color": todo.color,
        "category":todo.category
      };
      return await db.update(todoTable, row, where: "id = ?", whereArgs: [todo.id] );
    }
  }

  Future<List<Todo>> getAllTodo() async{
    Database db = await instance.database;
    List<Todo> todos = [];

    var queries = await db.query(todoTable);

    for (var q in queries){
      todos.add(Todo(
          id:q["id"],
          title: q["title"],
          date: q["date"],
          memo: q["memo"],
          done: q["done"],
          category: q["category"],
          color: q["color"]
      ));
    }

    return todos;
  }

  Future<List<Todo>> getTodoByDate(int date) async{
    Database db = await instance.database;
    List<Todo> todos = [];

    var queries = await db.query(todoTable, where: "date = ?", whereArgs: [date]);
    for (var q in queries){
      todos.add(Todo(
          id:q["id"],
          title: q["title"],
          date: q["date"],
          memo: q["memo"],
          done: q["done"],
          category: q["category"],
          color: q["color"]
      ));
    }
    return todos;
  }

}