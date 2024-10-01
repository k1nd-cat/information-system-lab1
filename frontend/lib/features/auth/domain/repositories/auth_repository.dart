import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String login, String password);
}