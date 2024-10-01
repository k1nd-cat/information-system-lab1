import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/main/presentation/screens/main_screen.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRemoteDataSource = AuthRemoteDataSource(client: http.Client());
    final authRepository =
        AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
    final loginUseCase = LoginUseCase(repository: authRepository);

    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => AuthBloc(loginUseCase: loginUseCase),
              child: LoginScreen(),
            ),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
