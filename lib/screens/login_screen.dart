import 'package:bloc_state_management/bloc/auth_bloc.dart';
import 'package:bloc_state_management/events/auth_event.dart';
import 'package:bloc_state_management/states/auth_state.dart';
import 'package:bloc_state_management/widgets/gradient_btn.dart';
import 'package:bloc_state_management/widgets/login_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Login Screen ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*BlocConsumer exposes a builder and listener in order react to new states.
      BlocConsumer should only be used when it is necessary to both rebuild UI and execute other reactions to state changes in the bloc.
      */
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // Handles side effects based on state changes (e.g., navigation, showing SnackBar)
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                ),
              ),
            );
          }

          if (state is AuthSuccess) {
            Navigator.pushNamed(context, '/add_todo');
          }
        },
        /*
        If you don't want to display the loading indicator that is the part of the UI then we can do the navigation task by using Bloc Listener.
        BlocListener is a Flutter widget which takes a BlocWidgetListener and an optional bloc and invokes the listener in response to state changes in the bloc.
        It should be used for functionality that needs to occur once per state change such as navigation, showing a SnackBar, showing a Dialog, etc...
         */
        builder: (context, state) {
          // Builds the UI based on the current state
          return SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/signin_balls.png"),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: LoginField(
                          hintText: 'Email',
                          controller: emailController,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: LoginField(
                          hintText: 'Password',
                          controller: passwordController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GradientButton(
                          text: "Sign in",
                          onPressed: state
                                  is AuthLoading // Disable button while loading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                        // Dispatch login event
                                        AuthLoginRequested(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        ),
                                      );
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
