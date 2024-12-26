class TodoEntity {
  final int id;
  final String text;
  final bool isCompleted;

  TodoEntity({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  TodoEntity toggleCompletion() {
    return TodoEntity(
      id: id,
      text: text,
      isCompleted: !isCompleted,
    );
  }
}
