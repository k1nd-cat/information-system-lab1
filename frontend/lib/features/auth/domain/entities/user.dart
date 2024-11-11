class User {
  final String login;
  final String token;
  final bool? isAdmin;

  User({required this.login, required this.token, required this.isAdmin});
}