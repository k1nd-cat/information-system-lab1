abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String login;
  final String password;

  LoginRequested({required this.login, required this.password});
}
