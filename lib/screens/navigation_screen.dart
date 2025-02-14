import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("All Screens"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Cubit Examples"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/product_screen');
                      },
                      child: const Text("Product API Example")),
                  const SizedBox(height: 20),
                ],
              ),
            )),
            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("By Both Cubit & Bloc Examples"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/counter_screen');
                      },
                      child: const Text("Counter Example")),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart_screen');
                      },
                      child: const Text("Cart Example")),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/todo_list');
                      },
                      child: const Text("Todo List Example")),
                  const SizedBox(height: 20),
                ],
              ),
            )),
            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Bloc Examples"),
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
                  const SizedBox(height: 20),
                ],
              ),
            )),
          ],
        ),
      )),
    );
  }
}
