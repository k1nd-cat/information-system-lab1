abstract class AuthEvent {}

class LoginRequest extends AuthEvent {
  final String login;
  final String password;

  LoginRequest({
    required this.login,
    required this.password,
  });
}

class RegisterRequest extends AuthEvent {
  final String login;
  final String password;
  final bool? isAdmin;

  RegisterRequest({
    required this.login,
    required this.password,
    required this.isAdmin,
  });
}
