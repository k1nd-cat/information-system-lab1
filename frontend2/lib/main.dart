import 'package:flutter/material.dart';
import 'package:frontend2/movie_app.dart';
import 'package:frontend2/repository/authentication_repository.dart';
import 'package:frontend2/repository/movie_repository.dart';
import 'package:frontend2/repository/user_repository.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:frontend2/viewmodel/home_viewmodel.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  final movieViewModel = MovieViewModel(MovieRepository());
  final authenticationViewModel = AuthenticationViewModel(AuthenticationRepository(), movieViewModel.onUpdateMovies);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => authenticationViewModel),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(
                  userRepository: UserRepository(),
                  adminRepository: UserRepository(),
                )),
        ChangeNotifierProvider(
            create: (_) => movieViewModel),
      ],
      child: const MovieApp(),
    ),
  );
}
