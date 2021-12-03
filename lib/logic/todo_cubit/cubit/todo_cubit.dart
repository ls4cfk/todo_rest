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
}
