abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String login;
  final String password;

  LoginRequested({
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

class ShowRegisterForm extends AuthEvent {}