import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_ex/logic/todo_cubit/cubit/todo_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        bloc: context.read<TodoCubit>()..fetchTodos(),
        builder: (context, state) {
          if (state is TodoInitial) {
            return const CircularProgressIndicator();
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.todoList[index].todo!),
                  subtitle: Text(state.todoList[index].description!),
                  trailing: CircleAvatar(
                    child: Text(
                      state.todoList[index].id.toString(),
                    ),
                  ),
                );
              },
              itemCount: state.todoList.length,
            );
          } else {
            return Center(
              child: Text((state as TodoLoadingError).errorMessage),
            );
          }
        },
      ),
    );
  }
}
