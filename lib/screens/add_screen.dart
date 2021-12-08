import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_ex/logic/todo_cubit/cubit/todo_cubit.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  static const routeName = '/create-todo';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextEditingController id = TextEditingController();
    TextEditingController todo = TextEditingController();
    TextEditingController description = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    child: TextFormField(
                      controller: id,
                      decoration: const InputDecoration(hintText: "Enter ID"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Valid ID";
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    child: TextFormField(
                      controller: todo,
                      decoration: const InputDecoration(hintText: "Enter todo"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter valid todo name";
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    child: TextFormField(
                      controller: description,
                      decoration:
                          const InputDecoration(hintText: "todo Description"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter valid Description";
                        }
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<TodoCubit>().addTodo(
                            int.tryParse(id.text), todo.text, description.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add"))
              ],
            )));
  }
}
