class Person {
  String name;
  Color eyeColor;
  Color hairColor;
  Location location;
  String passportID;
  Country nationality;

  Person({
    required this.name,
    required this.eyeColor,
    required this.hairColor,
    required this.location,
    required this.passportID,
    required this.nationality,
  });
}

class Location {
  double x;
  int y;
  int z;

  Location({
    required this.x,
    required this.y,
    required this.z,
  });
}

enum Color {
  RED,
  BLACK,
  WHITE;
}

enum Country {
  RUSSIA,
  INDIA,
  JAPAN;
}
