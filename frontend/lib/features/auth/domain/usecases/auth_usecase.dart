import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  Future<User> doLogin(String login, String password) async {
    return await repository.login(login, password);
  }

  Future<User> doRegister(String login, String password, bool? isAdmin) async {
    return await repository.register(login, password, isAdmin);
  }

  String? _checkValidLogin(String login) {

    return null;
  }

  String? _chackValidPassword(String? password, String? repeatedPassword) {

  }
}
