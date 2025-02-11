import 'package:bloc_state_management/bloc/todo_bloc.dart';
import 'package:bloc_state_management/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({super.key});

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Todo Title"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: todoController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TodoCubit>(context)
                      .addTodo(todoController.text);
                  context.read<TodoBloc>().add(TodoAdded(todoController.text));
                  todoController.clear();
                },
                child: const Text("Add"))
          ],
        ),
      )),
    );
  }
}
