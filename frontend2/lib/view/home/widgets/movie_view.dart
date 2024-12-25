import 'package:flutter/material.dart';
import 'package:frontend2/model/movies.dart' as model;

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final movie = model.Movie(
    name: 'Help me',
    coordinates: model.Coordinates(12, 13),
    oscarCount: 7,
    budget: 30000,
    totalBoxOffice: 16,
    mpaaRating: model.MpaaRating.NC_17,
    director: model.Person(
      name: 'Lukas Pukas',
      eyeColor: model.Color.RED,
      hairColor: model.Color.BLACK,
      location: model.Location(127, 241, 189.54),
      nationality: model.Country.RUSSIA,
      passportID: 'h238948ufdsqu3g94uogh33785',
    ),
    operator: model.Person(
      name: 'Genry Loruk',
      eyeColor: model.Color.BLACK,
      hairColor: model.Color.WHITE,
      location: model.Location(327, 121, 356.111),
      nationality: model.Country.RUSSIA,
      passportID: 'fsdh3ugh8yhjv487efr',
    ),
    length: 136,
    goldenPalmCount: 2,
    usaBoxOffice: 14,
    genre: model.MovieGenre.FANTASY,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(movie.name)
        ],
    );
  }
}
