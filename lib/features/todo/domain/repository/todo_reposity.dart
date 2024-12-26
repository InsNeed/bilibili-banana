import 'package:news/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getAllTodos();
  Future<void> addTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(TodoEntity todo);
}
