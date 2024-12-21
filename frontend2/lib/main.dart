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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationViewModel(AuthenticationRepository())),
        ChangeNotifierProvider(create: (_) => HomeViewModel(UserRepository())),
        ChangeNotifierProvider(create: (_) => MovieViewModel(MovieRepository())),
      ],
      child: const MovieApp(),
    ),
  );
}
