import 'dart:async';
import 'dart:io';
import 'todo.dart';
import 'todo_database_sqflite.dart';
import 'todo_database_sqlite3.dart';

class TodoDatabase {
  // Nullable Variable
  TodoDatabaseSqflite? _databaseSqflite;
  TodoDatabaseSqlite3? _databaseSqlite3;

  // Private Constructor
  TodoDatabase._();

  static Future<TodoDatabase> initialize() async {
    TodoDatabase todoDatabase = TodoDatabase._();
    if (Platform.isAndroid || Platform.isIOS) {
      todoDatabase._databaseSqflite = await TodoDatabaseSqflite.initialize();
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      todoDatabase._databaseSqlite3 = TodoDatabaseSqlite3.initialize();
    }
    return todoDatabase;
  }

  // Function to get completed todos
  Future<List<Todo>> todos({bool? completed}) async {
    if (Platform.isAndroid || Platform.isIOS) {
      return await _databaseSqflite?.todos(completed: completed) ??
          List.empty();
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      return await _databaseSqlite3?.todos(completed: completed) ??
          List.empty();
    }
    return List.empty();
  }

  // Function to insert _todo
  Future<void> insert(Todo todo) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await _databaseSqflite?.insert(todo);
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      await _databaseSqlite3?.insert(todo);
    }
  }

  // Function to delete given _todo
  Future<void> delete(Todo todo) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await _databaseSqflite?.delete(todo);
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      await _databaseSqlite3?.delete(todo);
    }
  }

  // Function to update _todo
  Future<void> update(Todo todo) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await _databaseSqflite?.update(todo);
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      await _databaseSqlite3?.update(todo);
    }
  }

  // Function to close the database
  Future<void> close() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await _databaseSqflite?.close();
    } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      await _databaseSqlite3?.close();
    }
  }
}
