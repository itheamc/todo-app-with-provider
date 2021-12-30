import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_with_provider/sqlitedb/todo.dart';

class TodoDatabaseSqflite {
  // Private const variables that can't be reassigned
  static const String _dbName = "db_todos.db";
  static const String _tableName = "todos";
  static const int _version = 1;
  Database? _database;

  // Private Constructor
  TodoDatabaseSqflite._();

  static Future<TodoDatabaseSqflite> initialize() async {
    TodoDatabaseSqflite todoDatabase = TodoDatabaseSqflite._()
      .._database = await _createDatabase();
    return todoDatabase;
  }

  // Private static function to create and return the instance of sql database
  static Future<Database> _createDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), _dbName),
        version: _version, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $_tableName (_id INTEGER PRIMARY KEY AUTOINCREMENT, _title TEXT, _desc TEXT, _completed INTEGER, _time INTEGER, _comp_time INTEGER)');
    });
  }

  // Function to get completed todos
  Future<List<Todo>> todos({bool? completed}) async {
    List<Map<String, dynamic>>? maps = await _database?.query(_tableName,
        columns: [
          '_id',
          '_title',
          '_desc',
          '_completed',
          '_time',
          '_comp_time'
        ],
        where: completed == null ? null : "_completed = ?",
        whereArgs: completed == null
            ? null
            : [completed ? 1 : 0]); // 0 -> false, 1 -> true

    return maps != null && maps.isNotEmpty ? Todo.fromMaps(maps) : List.empty();
  }

  // Function to insert _todo
  Future<bool> insert(Todo todo) async {
    int? res = await _database?.insert(
      _tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res != null;
  }

  // Function to delete given _todo
  Future<bool> delete(Todo todo) async {
    int? res = await _database
        ?.delete(_tableName, where: '_id = ?', whereArgs: [todo.id]);
    return res != null;
  }

  // Function to update _todo
  Future<bool> update(Todo todo) async {
    int? res = await _database?.update(_tableName, todo.toMap(),
        where: '_id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res != null;
  }

  // Function to close the database
  Future<void> close() async {
    if (_database != null && _database?.isOpen == true) {
      await _database?.close();
    }
  }
}
