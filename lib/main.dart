import 'package:bloc_state_management/bloc/auth_bloc.dart';
import 'package:bloc_state_management/bloc/todo_bloc.dart';
import 'package:bloc_state_management/cubit/todo_cubit.dart';
import 'package:bloc_state_management/observer/login_observer.dart';
import 'package:bloc_state_management/screens/add_todo_screen.dart';
import 'package:bloc_state_management/screens/counter_screen.dart';
import 'package:bloc_state_management/cubit/counter_cubit.dart';
import 'package:bloc_state_management/screens/login_screen.dart';
import 'package:bloc_state_management/screens/navigation_screen.dart';
import 'package:bloc_state_management/screens/todo_screen.dart';
import 'package:bloc_state_management/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_bloc.dart';
import 'data/provider/weather_data_provider.dart';
import 'data/repository/weather_repository.dart';

void main() {
  //Bloc.observer property to set your custom BlocObserver. Do this before you create any Blocs, typically in your main function:
  Bloc.observer = LoginObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    MultiBlocProvider is a Flutter widget that merges multiple BlocProvider widgets into one. 
    MultiBlocProvider improves the readability and eliminates the need to nest multiple BlocProviders
    */
    return RepositoryProvider(
      create: (context) => WeatherRepository(WeatherDataProvider()),
      child: MultiBlocProvider(
        providers: [
          /*
          BlocProvider is a Flutter widget which provides a bloc to its children via BlocProvider.of<T>(context).
          It is used as a dependency injection (DI) widget so that a single instance of a bloc can be provided to multiple widgets within a subtree.
          By default, BlocProvider will create the bloc lazily, meaning create will get executed when the bloc is looked up via BlocProvider.of<BlocA>(context).
          To override this behavior and force create to be run immediately, lazy can be set to false.
          */
          BlocProvider(
            create: (_) => CounterCubit(),
          ),
          BlocProvider(create: (_) => TodoCubit(), lazy: false),
          BlocProvider(create: (_) => TodoBloc(), lazy: false),
          BlocProvider(create: (_) => AuthBloc(), lazy: false),
          BlocProvider(create: (context) => WeatherBloc(context.read<WeatherRepository>()), lazy: false)
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
              '/': (_) => const NavigationScreen(),
              '/counter_screen': (_) => const CounterExample(),
              '/todo_list': (_) => const TodoListExample(),
              '/add_todo': (_) => AddTodoScreen(),
              '/login_screen': (_) => const LoginScreen(),
              '/weather_screen': (_) => const WeatherScreen(),
            }),
      ),
    );
  }
}
