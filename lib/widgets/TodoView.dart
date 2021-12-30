import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/providers/TodoProviders.dart';
import 'package:todo_app_with_provider/sqlitedb/todo.dart';
import 'package:todo_app_with_provider/utils/TimeUtils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoView extends StatelessWidget {
  final Todo todo;

  const TodoView({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addedDuration = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(todo.time));
    var completedDuration = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(todo.compTime));

    return Slidable(
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: _handleDone,
            icon:
                todo.completed ? Icons.remove_done_rounded : Icons.done_rounded,
            label: todo.completed ? "Mark as uncompleted" : "Mark as completed",
            backgroundColor: Colors.green,
          ),
          SlidableAction(
            onPressed: _delete,
            icon: Icons.delete_rounded,
            label: "Delete",
            backgroundColor: Colors.redAccent,
          )
        ]),
        child: ListTile(
            title: Text(todo.title,
                style: TextStyle(
                    decoration: todo.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.desc,
                    style: TextStyle(
                        decoration: todo.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
                Text(
                    todo.completed
                        ? "Completed ${fromDuration(completedDuration)}"
                        : "Added ${fromDuration(addedDuration)}",
                    style: const TextStyle(
                        fontSize: 8,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              ],
            )));
  }

  // Function to delete the _todo
  Future<void> _delete(BuildContext context) async {
    await context.read<TodoProvider>().delete(todo);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Deleted Successfully'),
          duration: Duration(seconds: 2)),
    );
  }

  // Function to handle mark as completed and mark as uncompleted the _todo
  Future<void> _handleDone(BuildContext context) async {
    var message = "";
    if (!todo.completed) {
      await context.read<TodoProvider>().update(todo.copy(
          completed: true, compTime: DateTime.now().millisecondsSinceEpoch));
      message = "Marked todo as completed.";
    } else {
      await context
          .read<TodoProvider>()
          .update(todo.copy(completed: false, compTime: -1));
      message = "Marked todo as uncompleted";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
