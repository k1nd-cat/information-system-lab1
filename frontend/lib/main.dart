import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/navigation/lab1_router_delegate.dart';
import 'package:frontend/features/navigation/bloc/navigation_bloc.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
import 'package:http/http.dart' as http;

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/auth_screen.dart';
import 'features/main/presentation/screens/main_screen.dart';

void main() {
  final navigationBloc = NavigationBloc();
  runApp(
    BlocProvider(
      create: (context) => navigationBloc,
      child: MyApp(navigationBloc: navigationBloc),
    ),
  );
}

class MyApp extends StatelessWidget {
  final NavigationBloc navigationBloc;

  const MyApp({super.key, required this.navigationBloc});

  @override
  Widget build(BuildContext context) {
    final authRemoteDataSource = AuthRemoteDataSource(client: http.Client());
    final authRepository =
        AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
    final loginUseCase = AuthUseCase(repository: authRepository);

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          // backgroundColor: Color.fromRGBO(246, 230, 210, 1.0),
        ),
        // scaffoldBackgroundColor: const Color.fromRGBO(254, 249, 239, 1),
      ),
      title: 'Lab1 333304',
/*
      routerDelegate: Lab1RouterDelegate(navigationBloc),
      routeInformationParser: Lab1RouteInformationParser(),
*/
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

class Lab1RouteInformationParser extends RouteInformationParser<Object> {

  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) async {
    return 'main';
  }
}
