import 'package:flutter/foundation.dart';
import 'package:todo_app_with_provider/sqlitedb/todo.dart';
import 'package:todo_app_with_provider/sqlitedb/todo_database.dart';

class TodoProvider with ChangeNotifier {
  TodoDatabase? _todoDatabase;
  Todo? _temp;

  Future<List<Todo>> todos() async {
    _todoDatabase ??= await init();
    return await _todoDatabase?.todos() ?? List.empty();
  }

  Future<void> insert(Todo todo) async {
    _todoDatabase ??= await init();
    await _todoDatabase?.insert(todo);
    notifyListeners();
  }

  Future<void> update(Todo todo) async {
    _todoDatabase ??= await init();
    await _todoDatabase?.update(todo);
    notifyListeners();
  }

  Future<void> delete(Todo todo) async {
    _todoDatabase ??= await init();
    _temp = todo.copy();
    await _todoDatabase?.delete(todo);
    notifyListeners();
  }

  Future<void> handleUndo() async {
    if (_temp != null) {
      await insert(_temp!);
    }
  }

  Future<TodoDatabase> init() async {
    return await TodoDatabase.initialize();
  }
}
