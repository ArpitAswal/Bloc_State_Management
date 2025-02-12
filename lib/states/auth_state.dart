// --- States --- (Define the possible states of the authentication process)
sealed class AuthState {} // Abstract class, base for all auth states

final class AuthInitial
    extends AuthState {} // Initial state, no authentication yet

final class AuthLoading
    extends AuthState {} // Loading state, during authentication/logout

final class AuthSuccess extends AuthState {
  // Success state, user is authenticated
  final String uid; // User ID (or UserModel in a real app)

  AuthSuccess({required this.uid});
}

final class AuthFailure extends AuthState {
  // Failure state, authentication/logout failed
  final String error;

  AuthFailure(this.error);
}
