import 'package:bloc_state_management/events/auth_event.dart';
import 'package:bloc_state_management/states/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Bloc --- (Handles the authentication logic and state transitions)
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    // Initialize with the initial state
    on<AuthLoginRequested>(
        _onAuthLoginRequested); // Register handler for login events
    on<AuthLogoutRequested>(
        _onAuthLogoutRequested); // Register handler for logout events
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit, // Emitter is used to emit new states
  ) async {
    emit(AuthLoading()); // Emit loading state to update UI

    try {
      final email = event.email;
      final password = event.password;

      await Future.delayed(
          const Duration(seconds: 1)); // Simulate authentication delay

      if (password.length < 6) {
        return emit(AuthFailure(
            'Password must be at least 6 characters!')); // Emit failure state
      }

      emit(AuthSuccess(uid: '$email-$password')); // Emit success state
    } catch (e) {
      emit(AuthFailure(e.toString())); // Emit failure state with error
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading()); // Emit loading state

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate logout delay

      emit(AuthInitial()); // Emit initial state after logout
    } catch (e) {
      emit(AuthFailure(e.toString())); // Emit failure state
    }
  }
}

// @override
// void onChange(Change<AuthState> change) {
//   super.onChange(change);
//   print('AuthBloc - Change - $change');
// }

// @override
// void onTransition(Transition<AuthEvent, AuthState> transition) {
//   super.onTransition(transition);
//   print('AuthBloc - Transition - $transition');
// }
