import 'package:flutter/foundation.dart';
import 'package:todo_app_with_provider/sqlitedb/todo.dart';
import 'package:todo_app_with_provider/sqlitedb/todo_database.dart';

class TodoProvider with ChangeNotifier {
  TodoDatabase? _todoDatabase;

  Future<List<Todo>> todos() async {
    _todoDatabase ??= await TodoDatabase.initialize();
    return await _todoDatabase?.todos() ?? List.empty();
  }

  Future<void> insert(Todo todo) async {
    _todoDatabase ??= await TodoDatabase.initialize();
    await _todoDatabase?.insert(todo);
    notifyListeners();
  }

  Future<void> update(Todo todo) async {
    _todoDatabase ??= await TodoDatabase.initialize();
    await _todoDatabase?.update(todo);
    notifyListeners();
  }

  Future<void> delete(Todo todo) async {
    _todoDatabase ??= await TodoDatabase.initialize();
    await _todoDatabase?.delete(todo);
    notifyListeners();
  }
}
