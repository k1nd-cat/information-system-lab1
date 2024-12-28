import 'package:flutter/cupertino.dart';
import 'package:frontend2/dto/movies_page_request.dart';
import 'package:frontend2/repository/movie_repository.dart';

import '../model/movies.dart';

class MovieViewModel with ChangeNotifier {
  final MovieRepository repository;
  Movie? editableMovie;
  int _page = 1;
  late int _size = 10;
  int pageCount = 0;
  List<Movie> movies = [];
  String namePrefix = '';
  int minGoldenPalmCount = -1;
  bool isUsaBoxOfficeUnique = false;
  bool isLoading = true;

  MovieViewModel(this.repository);

  int get size => _size;

  int get page => _page;

  set size(int size) {
    _size = size;
    // getMoviesPage();
    // notifyListeners();
  }

  set page(int page) {
    _page = page;
    getMoviesPage();
    // notifyListeners();
  }

  Future<List<Person>> getPersons(String token) async {
    return await repository.getAllPersons(token);
  }

  createMovie(String token, Movie movie) {
    repository.create(token, movie);
  }

  updateMovie(String token, Movie movie) {
    repository.update(token, movie);
  }

  deleteMovie(Movie movie) {
    repository.delete(movie);
  }

  @Deprecated('Использовать метод [getMoviesPage]')
  Future<List<Movie>> getMovies(int page, int size) async {
    // try {
    return await repository.getMovies(page, size);
    // } catch (e) {
    //   throw Exception('Вот где-то тут не хочет отрабатывать');
    // }
  }

  Future<void> getMoviesPage([bool changeIsLoading = true]) async {
    // print('begin');
    if (changeIsLoading) {
      isLoading = true;
    }
    notifyListeners();

    final moviesPageRequest = MoviesPageRequest(
      size: size,
      page: page,
      namePrefix: namePrefix,
      minGoldenPalmCount: minGoldenPalmCount,
      isUsaBoxOfficeUnique: isUsaBoxOfficeUnique,
    );

    var moviesPage = await repository.getMoviesPage(moviesPageRequest);
    pageCount = moviesPage.pageCount;
    movies = moviesPage.movies;
    if (changeIsLoading) {
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> applyFilters(
    String namePrefix,
    int minGoldenPalmCount,
    bool isUsaBoxOfficeUnique,
  ) async {
    _page = 1;
    this.namePrefix = namePrefix;
    this.minGoldenPalmCount = minGoldenPalmCount;
    this.isUsaBoxOfficeUnique = isUsaBoxOfficeUnique;
    await getMoviesPage();
  }

  void onUpdateMovies(String message) {
    getMoviesPage(false);
  }

  Future<List<Person>> showOperatorWithZeroOscar() async {
    return await repository.showOperatorWithZeroOscar();
  }
}
