import 'package:flutter/cupertino.dart';
import 'package:frontend2/repository/movie_repository.dart';

import '../model/movies.dart';

class MovieViewModel with ChangeNotifier {
  final MovieRepository repository;
  Movie? editableMovie;

  MovieViewModel(this.repository);

  Future<List<Person>> getPersons(String token) async {
    return await repository.getAllPersons(token);
  }

  createMovie(String token, Movie movie) {
    repository.create(token, movie);
  }

  updateMovie(String token, Movie movie) {
    repository.update(token, movie);
  }
}