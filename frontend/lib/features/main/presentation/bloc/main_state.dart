import 'package:frontend/features/main/domain/entities/Movie.dart';

abstract class MainState {}

class MainInitialState extends MainState {}

class MainLoadingState extends MainState {}

class MainLoadedState extends MainState {
  final List<Movie> movies;

  MainLoadedState(this.movies);
}

class MainErrorState extends MainState {
  final String errorMessage;
  MainErrorState(this.errorMessage);
}

