import 'package:flutter/material.dart';
import 'package:frontend2/movie_app.dart';
import 'package:frontend2/repository/authentication_repository.dart';
import 'package:frontend2/repository/user_repository.dart';
import 'package:frontend2/viewmodel/authentication/authentication_viewmodel.dart';
import 'package:frontend2/viewmodel/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationViewModel(AuthenticationRepository())),
        ChangeNotifierProvider(create: (_) => HomeViewModel(UserRepository())),
      ],
      child: const MovieApp(),
    ),
  );
}
