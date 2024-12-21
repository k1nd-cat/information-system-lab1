import 'package:flutter/cupertino.dart';
import 'package:frontend2/repository/movie_repository.dart';

import '../model/movies.dart';

class MovieViewModel with ChangeNotifier {
  final MovieRepository repository;
  Movies? editableMovie;

  MovieViewModel(this.repository);

  Future<List<Person>> getPersons(String token) async {
    return await repository.getAllPersons(token);
  }

  createMovie(String token, Movies movie) {
    repository.create(token, movie);
  }

  updateMovie(String token, Movies movie) {
    repository.update(token, movie);
  }
}