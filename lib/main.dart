import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_ex/logic/todo_cubit/cubit/todo_cubit.dart';
import 'package:rest_api_ex/routes/routes.dart';
import 'package:rest_api_ex/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: routePaths,
      ),
    );
  }
}
