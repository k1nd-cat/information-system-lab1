import 'package:frontend2/model/movies.dart';

class MoviesPage {
  final List<Movie> movies;
  final int pageCount;

  MoviesPage({
    required this.movies,
    required this.pageCount,
  });

  factory MoviesPage.fromJson(Map<String, dynamic> json) {
    return MoviesPage(
      movies: (json['movies'] as List).map((movieJson) => Movie.fromJson(movieJson)).toList(),
      pageCount: json['pageCount'],
    );
  }
}
