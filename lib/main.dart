import 'package:bloc_state_management/blocs/auth_bloc.dart';
import 'package:bloc_state_management/blocs/todo_bloc.dart';
import 'package:bloc_state_management/cubits/todo_cubit.dart';
import 'package:bloc_state_management/observer/login_observer.dart';
import 'package:bloc_state_management/screens/add_todo_screen.dart';
import 'package:bloc_state_management/screens/cart_screen.dart';
import 'package:bloc_state_management/screens/counter_screen.dart';
import 'package:bloc_state_management/cubits/counter_cubit.dart';
import 'package:bloc_state_management/screens/home_screen.dart';
import 'package:bloc_state_management/screens/login_screen.dart';
import 'package:bloc_state_management/screens/navigation_screen.dart';
import 'package:bloc_state_management/screens/product_screen.dart';
import 'package:bloc_state_management/screens/todo_screen.dart';
import 'package:bloc_state_management/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cart_bloc.dart';
import 'blocs/weather_bloc.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/product_cubit.dart';
import 'data/providers/product_data_provider.dart';
import 'data/providers/weather_data_provider.dart';
import 'data/repositories/product_repository.dart';
import 'data/repositories/weather_repository.dart';

void main() {
  //Bloc.observer property to set your custom BlocObserver. Do this before you create any Blocs, typically in your main function:
  Bloc.observer = LoginObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //MultiRepositoryProvider is a Flutter widget that merges multiple RepositoryProvider widgets into one.
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => WeatherRepository(WeatherDataProvider())),
        RepositoryProvider(
            create: (context) => ProductRepository(ProductDataProvider())),
      ],
      // MultiBlocProvider is a Flutter widget that merges multiple BlocProvider widgets into one.
      child: MultiBlocProvider(
        providers: [
          /*
            BlocProvider is a Flutter widget which provides a bloc to its children via BlocProvider.of<T>(context).
            By default, BlocProvider will create the bloc lazily, meaning create will get executed when the bloc is looked up via BlocProvider.of<BlocA>(context).
            To override this behavior and force create to be run immediately, lazy can be set to false.
            */
          BlocProvider(create: (_) => CounterCubit()),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => CartBloc()),
          BlocProvider(create: (_) => TodoCubit(), lazy: false),
          BlocProvider(create: (_) => TodoBloc(), lazy: false),
          BlocProvider(create: (_) => AuthBloc(), lazy: false),
          BlocProvider(
              create: (context) =>
                  WeatherBloc(context.read<WeatherRepository>()),
              lazy: false),
          BlocProvider(
              create: (context) =>
                  ProductCubit(context.read<ProductRepository>()),
              lazy: false),
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
              '/home_screen': (_) => const HomeScreen(),
              '/weather_screen': (_) => const WeatherScreen(),
              '/product_screen': (_) => const ProductScreen(),
              '/cart_screen': (_) => const CartScreen(),
            }),
      ),
    );
  }
}
