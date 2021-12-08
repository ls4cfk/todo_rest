import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rest_api_ex/data/models/todo.dart';
import 'package:rest_api_ex/data/repository/todo_repository.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  final todoRepository = TodoRepository();

  Future<void> fetchTodos() async {
    emit(TodoInitial());
    try {
      var todoList = await todoRepository.fetchTodos();
      emit(TodoLoaded(todoList!));
    } catch (e) {
      emit(
        TodoLoadingError(e.toString()),
      );
    }
  }

  Future<void> removeTodo(todoID) async {
    var result = await todoRepository.removeTodo(todoID);
    if (result!) {
      try {
        var todoList = await todoRepository.fetchTodos();
        emit(TodoLoaded(todoList!));
      } catch (e) {
        emit(
          TodoLoadingError(e.toString()),
        );
      }
    }
  }

  Future<void> addTodo(id, todo, description) async {
    try {
      var result = await todoRepository.addTodo(id, todo, description);
      var todoList = await todoRepository.fetchTodos();
      emit(TodoLoaded(todoList!));
    } catch (e) {
      emit(TodoLoadingError(e.toString()));
    }
  }
}
