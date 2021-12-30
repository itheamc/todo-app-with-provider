import 'dart:async';
import 'package:sqlite3/sqlite3.dart';
import 'package:todo_app_with_provider/sqlitedb/todo.dart';

class TodoDatabaseSqlite3 {
  // Private const variables that can't be reassigned
  static const String _tableName = "todos";
  Database? _database;

  // Private Constructor
  TodoDatabaseSqlite3._();

  static TodoDatabaseSqlite3 initialize() {
    TodoDatabaseSqlite3 todoDatabase = TodoDatabaseSqlite3._()
      .._database = _createDatabase();
    return todoDatabase;
  }

  // Private static function to create and return the instance of sql database
  static Database _createDatabase() {
    final db = sqlite3.openInMemory();
    if (db.getUpdatedRows() <= 0) {
      db.execute(
          'CREATE TABLE $_tableName (_id INTEGER PRIMARY KEY AUTOINCREMENT, _title TEXT, _desc TEXT, _completed INTEGER, _time INTEGER, _comp_time INTEGER)');
    }
    return db;
  }

  // Function to get completed todos
  Future<List<Todo>> todos({bool? completed}) async {
    var result = _database?.select(
        'SELECT * FROM $_tableName${completed == null ? "" : " WHERE _completed = ${completed == true ? 1 : 0}"}');
    if (result != null && result.isNotEmpty) {
      final rows = result.rows;
      if (rows.isNotEmpty) {
        final maps = rows
            .map((e) => {
                  "_id": e[0],
                  "_title": e[1],
                  "_desc": e[2],
                  "_completed": e[3],
                  "_time": e[4]
                })
            .toList();
        return Todo.fromMaps(maps);
      }
    }
    return List.empty();
  }

  // Function to insert _todo
  Future<void> insert(Todo todo) async {
    _database?.execute('INSERT INTO $_tableName VALUES ${todo.toValues()}');
  }

  // Function to delete given _todo
  Future<void> delete(Todo todo) async {
    _database?.execute('DELETE FROM $_tableName WHERE _id = ${todo.id}');
  }

  // Function to update _todo
  Future<void> update(Todo todo) async {
    _database?.execute('''
    UPDATE $_tableName SET _title = ${todo.title}, _desc = ${todo.desc}, _completed = ${todo.completed ? 1 : 0}
    WHERE _id = ${todo.id}
    ''');
  }

  // Function to close the database
  Future<void> close() async {
    if (_database != null) {
      _database?.dispose();
    }
  }
}
