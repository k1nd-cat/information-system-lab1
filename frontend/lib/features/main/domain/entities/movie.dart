import 'person.dart';

class Movie {
  int id;
  String name;
  Coordinates coordinates;
  DateTime creationDate;
  int oscarsCount;
  double budget;
  double totalBoxOffice;
  MpaaRating mpaaRating;
  Person director;
  Person screenwriter;
  Person operator;
  int length;
  int goldenPalmCount;
  double usaBoxOffice;
  MovieGenre genre;

  Movie({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.creationDate,
    required this.oscarsCount,
    required this.budget,
    required this.totalBoxOffice,
    required this.mpaaRating,
    required this.director,
    required this.screenwriter,
    required this.operator,
    required this.length,
    required this.goldenPalmCount,
    required this.usaBoxOffice,
    required this.genre,
  });

  String genreToString() => switch (genre) {
        MovieGenre.ACTION => 'Экшен',
        MovieGenre.FANTASY => 'Фэнтези',
        MovieGenre.WESTERN => 'Вестерн'
      };

  String mpaaRatingToString() => mpaaRating.toString().split('.').last;
}

class Coordinates {
  double x;
  double y; //Поле не может быть null

  Coordinates({
    required this.x,
    required this.y,
  });
}

enum MpaaRating {
  G,
  PG_13,
  NC_17;
}

enum MovieGenre {
  ACTION,
  WESTERN,
  FANTASY;
}
