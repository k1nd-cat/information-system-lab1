import 'dart:math';

import '../../domain/entities/person.dart';
import '../../domain/entities/movie.dart';

class MovieLocalDataSource {

  List<Movie> generateMovies() {
    final random = Random();

    List<Movie> movies = List.generate(15, (index) {
      return Movie(
        id: index + 1,
        name: 'Movie ${index + 1}',
        coordinates: Coordinates(
          x: random.nextDouble() * 180 - 90, // Случайная широта
          y: random.nextDouble() * 360 - 180, // Случайная долгота
        ),
        creationDate: DateTime.now().subtract(Duration(days: random.nextInt(365 * 20))), // Последние 20 лет
        oscarsCount: random.nextInt(5), // От 0 до 4
        budget: random.nextDouble() * 100000000, // До 100 млн
        totalBoxOffice: random.nextDouble() * 500000000, // До 500 млн
        mpaaRating: MpaaRating.values[random.nextInt(MpaaRating.values.length)],
        director: generateRandomPerson(random, 'Director ${index + 1}'),
        screenwriter: generateRandomPerson(random, 'Screenwriter ${index + 1}'),
        operator: generateRandomPerson(random, 'Operator ${index + 1}'),
        length: random.nextInt(121) + 60, // От 60 до 180 минут
        goldenPalmCount: random.nextInt(3), // От 0 до 2
        usaBoxOffice: random.nextDouble() * 300000000, // До 300 млн
        genre: MovieGenre.values[random.nextInt(MovieGenre.values.length)],
      );
    });

    return movies;
  }

  Person generateRandomPerson(Random random, String name) {
    return Person(
      name: name,
      eyeColor: Color.values[random.nextInt(Color.values.length)],
      hairColor: Color.values[random.nextInt(Color.values.length)],
      location: Location(
        x: random.nextDouble() * 180 - 90, // Случайная широта
        y: random.nextInt(100), // Случайная высота
        z: random.nextInt(100), // Случайная глубина
      ),
      passportID: 'P-${random.nextInt(100000).toString().padLeft(5, '0')}',
      nationality: Country.values[random.nextInt(Country.values.length)],
    );
  }
}