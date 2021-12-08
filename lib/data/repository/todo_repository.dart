import 'package:dio/dio.dart';
import 'package:rest_api_ex/data/models/todo.dart';

class TodoRepository {
  List<Todo>? todoList = [];
  Dio dio = Dio();

  Future<List<Todo>?>? fetchTodos() async {
    final response = await dio.get('http://10.0.2.2:8080/todos');
    if (response.statusCode == 200) {
      var loadedTodo = <Todo>[];
      response.data.forEach((todo) {
        Todo todoModel = Todo.fromJson(todo);
        loadedTodo.add(todoModel);
        todoList = loadedTodo;
        return todoList;
      });
    }
    return todoList;
  }

  Future<List<Todo>?>? fetchTodo(todoID) async {
    final response = await dio.get('http://10.0.2.2:8080/todo/$todoID');
    if (response.statusCode == 200) {
      var loadedTodo = <Todo>[];
      Todo todoModel = Todo.fromJson(response.data);
      loadedTodo.add(todoModel);
      todoList = loadedTodo;
      return todoList;
    }
    return todoList;
  }

  Future<bool>? removeTodo(todoID) async {
    final response =
        await dio.delete('http://10.0.2.2:8080/delete-todo/$todoID');
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<Todo>? addTodo(id, todo, description) async {
    Todo todoData = Todo(id: id, todo: todo, description: description);
    final response = await dio.post('http://10.0.2.2:8080/add-todo',
        data: todoData.toJson());
    if (response.statusCode == 200) {
      var createdTodo = Todo.fromJson(response.data);
      todoList!.add(createdTodo);
      return todoData;
    }
    return todoData;
  }
}
