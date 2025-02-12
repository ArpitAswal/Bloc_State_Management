// --- Events --- (Define what can happen in the authentication process)

sealed class AuthEvent {} // Abstract class, base for all auth events

final class AuthLoginRequested extends AuthEvent {
  // Event for login request
  final String email;
  final String password;

  AuthLoginRequested({
    required this.email,
    required this.password,
  });
}

final class AuthLogoutRequested extends AuthEvent {} // Event for logout request
