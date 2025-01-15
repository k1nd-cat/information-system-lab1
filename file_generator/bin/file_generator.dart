import 'dart:convert';
import 'dart:math';
// import 'package:yaml/yaml.dart';
// import 'package:yaml_writer/yaml_writer.dart';

import 'package:file_generator/model.dart';
import 'package:yaml_writer/yaml_writer.dart';

void main(List<String> arguments) {
  final isYaml = false;
  final random = Random();
  final movies = List.generate(50, (_) => generateRandomMovie(random, isYaml));

  if (!isYaml) {
    print(jsonEncode(movies.map((m) => m.toJson()).toList()));
  } else {
    final yamlWriter = YamlWriter();
    print(yamlWriter.write(movies.map((m) => m.toJson()).toList()));
  }
}

Movie generateRandomMovie(Random random, bool isYaml) {
  return Movie(
    name: '${isYaml ? 'YAML' : 'JSON'} ${random.nextInt(100)}',
    coordinates: Coordinates(
      random.nextDouble() * 1000 - 945,
      random.nextInt(1000),
    ),
    oscarCount: random.nextInt(10) + 1,
    budget: random.nextDouble() * 100000 + 10000,
    totalBoxOffice: random.nextDouble() * 500000 + 50000,
    mpaaRating: MpaaRating.values[random.nextInt(MpaaRating.values.length)],
    director: generateRandomPerson(random),
    screenwriter: random.nextBool() ? generateRandomPerson(random) : null,
    operator: generateRandomPerson(random),
    length: random.nextInt(141) + 60,
    goldenPalmCount: random.nextInt(5) + 1,
    usaBoxOffice: random.nextBool() ? random.nextInt(200000) + 10000 : null,
    genre: MovieGenre.values[random.nextInt(MovieGenre.values.length)],
    isEditable: random.nextBool(),
  );
}

Person generateRandomPerson(Random random) {
  return Person(
    name: 'Person ${random.nextInt(100)}',
    eyeColor: Color.values[random.nextInt(Color.values.length)],
    hairColor: Color.values[random.nextInt(Color.values.length)],
    location: random.nextBool()
        ? Location(
      random.nextInt(1000),
      random.nextInt(1000),
      random.nextDouble() * 100,
    )
        : null,
    nationality: Country.values[random.nextInt(Country.values.length)],
    passportID: 'P${random.nextInt(1000000).toString().padLeft(6, '0')}',
    isEditable: random.nextBool(),
  );
}

