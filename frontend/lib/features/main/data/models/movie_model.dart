import '../../domain/entities/person.dart';

class MovieModel {
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

  MovieModel({
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
