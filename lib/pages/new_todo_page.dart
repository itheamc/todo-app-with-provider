import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_provider/providers/todo_provider.dart';
import 'package:todo_app_with_provider/sqlitedb/todo.dart';

class NewTodoPage extends StatelessWidget {
  NewTodoPage({Key? key}) : super(key: key);

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  // Global Key for Form
  final _formKey = GlobalKey<FormState>();

  // Function to be called whenever save button is clicked
  void _onPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<TodoProvider>().insert(Todo(
          title: _titleController.text,
          desc: _descController.text,
          time: DateTime.now().millisecondsSinceEpoch));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved'), duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Todo"),
        actions: [
          IconButton(
              onPressed: () {
                _onPressed(context);
              },
              icon: const Icon(Icons.save_rounded))
        ],
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please give a title";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Title",
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.lato(color: Colors.grey)),
                        style: GoogleFonts.lato(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textInputAction: TextInputAction.done,
                      ),
                      TextFormField(
                          controller: _descController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please write a description..";
                            }
                            return null;
                          },
                          maxLines:
                              (MediaQuery.of(context).size.height - 100) ~/ 25,
                          decoration: InputDecoration(
                              hintText: "Description",
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.lato(color: Colors.grey)),
                          style: GoogleFonts.lato(
                            fontSize: 16,
                          )),
                    ],
                  )),
            )),
      ),
    );
  }
}
