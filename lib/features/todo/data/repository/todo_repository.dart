import 'package:isar/isar.dart';
import 'package:news/features/todo/data/model/todo_model.dart';
import 'package:news/features/todo/domain/entities/todo.dart';
import 'package:news/features/todo/domain/repository/todo_reposity.dart';

class TodoRepositoryImpl extends TodoRepository {
  final Isar db;

  TodoRepositoryImpl(this.db);

  @override
  Future<void> addTodo(TodoEntity todo) {
    final todoIsar = TodoIsar.fromDomain(todo);
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> deleteTodo(TodoEntity todo) {
    final todoIsar = TodoIsar.fromDomain(todo);
    return db.writeTxn(() => db.todoIsars.delete(todoIsar.id));
  }

  @override
  Future<List<TodoEntity>> getAllTodos() async {
    final todos = await db.todoIsars.where().findAll();
    return todos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(TodoEntity todo) {
    final todoIsar = TodoIsar.fromDomain(todo);
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
}
