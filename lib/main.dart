import 'package:bloc_state_management/bloc/todo_bloc.dart';
import 'package:bloc_state_management/cubit/todo_cubit.dart';
import 'package:bloc_state_management/screens/add_todo_screen.dart';
import 'package:bloc_state_management/screens/bloc_screen.dart';
import 'package:bloc_state_management/cubit/counter_cubit.dart';
import 'package:bloc_state_management/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterCubit(),
        ),
        BlocProvider(create: (_) => TodoCubit()),
        BlocProvider(create: (_) => TodoBloc())
      ],
      child: MaterialApp(
          title: 'Bloc App State',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              titleMedium: TextStyle(color: Colors.white),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (_) => const CounterExample(),
            '/todo-list': (_) => const TodoListScreen(),
            '/add-todo': (_) => AddTodoScreen()
          }),
    );
  }
}
