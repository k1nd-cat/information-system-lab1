import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    return User(login: 'test', token: userModel.token, isAdmin: userModel.isAdmin);
  }

  @override
  Future<User> register(String email, String password, bool? isAdmin) async {
    final userModel = await remoteDataSource.register(email, password, isAdmin);
    return User(login: 'test', token: userModel.token, isAdmin: userModel.isAdmin);
  }
}
