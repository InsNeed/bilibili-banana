import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/todo/domain/entities/todo.dart';
import 'package:news/features/todo/presentation/todo_cubit.dart';
import 'todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddTodoBox(context),
          child: const Icon(Icons.add)),
      body: BlocBuilder<TodoCubit, List<TodoEntity>>(builder: (context, todos) {//TODO:??
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              //text
              title: Text(todo.text),
              //checkbox
              leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.updateTodo(todo)),
              //delete
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => todoCubit.deleteTodo(todo),
              ),
            );
          },
        );
      }),
    );
  }

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add Todo'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    todoCubit.addTodo(textController.text); //!!!!
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ));
  }
}
