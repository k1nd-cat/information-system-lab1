import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String login, String password);
  Future<User> register(String login, String password, bool? register);
}