import 'package:bloc_state_management/bloc/auth_bloc.dart';
import 'package:bloc_state_management/events/auth_event.dart';
import 'package:bloc_state_management/screens/login_screen.dart';
import 'package:bloc_state_management/states/auth_state.dart';
import 'package:bloc_state_management/widgets/gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is AuthSuccess || state is AuthLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state is AuthLoading
                  ? const Text(
                      "User sign out",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white),
                    )
                  : Text(
                      'Welcome, ${(state as AuthSuccess).uid}', // Access uid from AuthSuccess state
                      style: const TextStyle(color: Colors.white),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 12.0),
                child: GradientButton(
                  text: "Sign out",
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                ),
              ),
            ],
          );
        } else {
          // Handle other states (e.g., AuthInitial)
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
