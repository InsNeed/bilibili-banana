import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/todo/domain/repository/todo_reposity.dart';
import 'package:news/features/todo/presentation/todo_cubit.dart';
import 'package:news/features/todo/presentation/todo_view.dart';

class TodoPage extends StatelessWidget {
  final TodoRepository todoRepo;
  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepo), // 假设您有一个 TodoBloc 类
      child: TodoView(),
    );
  }
}
