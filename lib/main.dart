import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/pages/HomePage.dart';
import 'package:todo_app_with_provider/pages/NewTodoPage.dart';
import 'package:todo_app_with_provider/providers/TodoProviders.dart';


void main() {
  runApp(const TodoApp());
}

// _Todo App Widget
class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        title: "Todo App",
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/newtodo': (context) => NewTodoPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}



