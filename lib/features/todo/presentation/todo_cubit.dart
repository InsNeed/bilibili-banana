import 'package:flutter/material.dart';
import 'package:news/features/todo/domain/entities/todo.dart';
import 'package:news/features/todo/domain/repository/todo_reposity.dart';
import 'package:bloc/bloc.dart';

class TodoCubit extends Cubit<List<TodoEntity>> {
  final TodoRepository _todoRepository;

  TodoCubit(this._todoRepository) : super([]) {
    loadTodos();
  }
  //LOAD
  Future<void> loadTodos() async {
    final todoList = await _todoRepository.getAllTodos();
    emit(todoList);
  }

  //ADD
  Future<void> addTodo(String text) async {
    final newTodo = TodoEntity(
      id: DateTime.now().microsecondsSinceEpoch,
      text: text,
    );
    await _todoRepository.addTodo(newTodo);
    loadTodos();
  }

  //DELETE
  Future<void> deleteTodo(TodoEntity todo) async {
    await _todoRepository.deleteTodo(todo);
    loadTodos();
  }

  //UPDATE
  Future<void> updateTodo(TodoEntity todo) async {
    final updateTodo = todo.toggleCompletion();
    await _todoRepository.updateTodo(updateTodo);
    loadTodos();
  }
}
