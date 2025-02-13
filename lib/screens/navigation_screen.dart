import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("All Bloc Screens"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/counter_screen');
                    },
                    child: const Text("Counter Example")),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/todo_list');
                    },
                    child: const Text("Todo List Example")),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login_screen');
                    },
                    child: const Text("Login Form Example")),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/weather_screen');
                    },
                    child: const Text("Weather API Example")),
              ],
            ),
          )),
    );
  }
}
