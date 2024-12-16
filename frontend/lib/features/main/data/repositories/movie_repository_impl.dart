import 'package:frontend/features/main/domain/entities/filters.dart';
import 'package:frontend/features/main/domain/entities/movie.dart';
import 'package:frontend/features/main/domain/entities/person.dart';
import 'package:frontend/features/main/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<void> awardMoviesByLength(int minLength, int monOscarCount) {
    // TODO: implement awardMoviesByLength
    throw UnimplementedError();
  }

  @override
  Future<List<Person>> getAllPersons() {
    // TODO: implement getAllPersons
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getMoviesOnPage(int pageNumber, int pagesCount, MovieFilters movieFilters) {
    // TODO: implement getMoviesOnPage
    throw UnimplementedError();
  }

}