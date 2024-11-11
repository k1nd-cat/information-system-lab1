import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/auth_screen.dart';
import 'features/main/presentation/screens/main_screen.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
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
    final loginUseCase = AuthUseCase(repository: authRepository);

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(246, 230, 210, 1.0),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(254, 249, 239, 1),
      ),
      title: 'Lab1 333304',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => AuthBloc(loginUseCase: loginUseCase),
              child: const AuthScreen(),
            ),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
