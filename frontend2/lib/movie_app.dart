import 'package:flutter/material.dart';
import 'package:frontend2/repository/movie_repository.dart';
import 'package:frontend2/view/authentication/authentication_screen.dart';
import 'package:frontend2/view/home/home_screen.dart';
import 'package:frontend2/view/loading_screen.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IS Labs",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(79, 79, 81, 1),
          titleTextStyle:
              TextStyle(color: Color.fromRGBO(214, 214, 214, 1), fontSize: 20),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(44, 43, 48, 1),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color.fromRGBO(214, 214, 214, 1),
          ),
          bodyMedium: TextStyle(
            color: Color.fromRGBO(214, 214, 214, 1),
          ),
          bodySmall: TextStyle(
            color: Color.fromRGBO(214, 214, 214, 1),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/auth': (context) => const AuthenticationScreen(),
        '/home': (context) => HomeScreen(movieViewModel: Provider.of<MovieViewModel>(context)),
      },
    );
  }
}
