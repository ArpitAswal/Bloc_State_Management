import 'package:bloc_state_management/bloc/todo_bloc.dart';
import 'package:bloc_state_management/cubit/todo_cubit.dart';
import 'package:bloc_state_management/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/todo_state.dart';

class TodoListExample extends StatelessWidget {
  const TodoListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Todo List"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add_todo'),
          tooltip: "Add Todo",
          child: const Icon(Icons.add),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            state.todos[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<TodoCubit, List<TodoModel>>(
                    builder: (context, todos) {
                  return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return ListTile(
                          title: Text(todo.name),
                          subtitle: Text(todo.createdAt.toString()),
                        );
                      });
                }),
              ),
            ],
          ),
        ));
  }
}
