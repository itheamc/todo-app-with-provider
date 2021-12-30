import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/providers/todo_provider.dart';
import 'package:todo_app_with_provider/sqlitedb/todo.dart';
import 'package:todo_app_with_provider/widgets/todo_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Todos"),
      ),
      body: FutureBuilder(
        future: context.watch<TodoProvider>().todos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.requireData.length,
              itemBuilder: (BuildContext context, int index) {
                return TodoView(
                    todo: snapshot
                        .requireData[snapshot.requireData.length - index - 1]);
              },
            );
          } else {
            return const Center(
              child: Text("No Todos"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/newtodo");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}