import 'package:news/features/todo/domain/entities/todo.dart';
import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@Collection()
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool completed;

  TodoEntity toDomain() {
    return TodoEntity(
      id: id,
      text: text,
      isCompleted: completed,
    );
  }

  static TodoIsar fromDomain(TodoEntity todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..completed = todo.isCompleted;
  }
}
