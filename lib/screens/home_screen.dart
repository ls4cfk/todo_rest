import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_ex/logic/todo_cubit/cubit/todo_cubit.dart';
import 'package:rest_api_ex/screens/add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List'), actions: [
        IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, CreateScreen.routeName);
            })
      ]),
      body: BlocBuilder<TodoCubit, TodoState>(
        bloc: context.read<TodoCubit>()..fetchTodos(),
        builder: (context, state) {
          if (state is TodoInitial) {
            return const CircularProgressIndicator();
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  key: UniqueKey(),
                  // direction: DismissDirection.,
                  // onTap: () => Navigator.pushNamed(
                  //     context, CarDetails.routeName, arguments: car),
                  onDismissed: (direction) {
                    context
                        .read<TodoCubit>()
                        .removeTodo(state.todoList[index].id);
                  },
                  child: ListTile(
                    title: Text(state.todoList[index].todo!),
                    subtitle: Text(state.todoList[index].description!),
                    trailing: CircleAvatar(
                      child: Text(
                        state.todoList[index].id.toString(),
                      ),
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
