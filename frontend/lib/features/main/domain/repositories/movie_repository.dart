import 'package:frontend/features/main/domain/entities/filters.dart';

import '../entities/movie.dart';
import '../entities/person.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMoviesOnPage(int pageNumber, int pagesCount, MovieFilters movieFilters);

  Future<List<Person>> getAllPersons();

  Future<void> awardMoviesByLength(int minLength, int monOscarCount);
}