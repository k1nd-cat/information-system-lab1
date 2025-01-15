import 'dart:convert';

class Movie {
  int? id;
  late String _name;
  Coordinates coordinates;
  DateTime? creationDate;
  late int _oscarCount;
  late double _budget;
  late double _totalBoxOffice;
  MpaaRating mpaaRating;
  Person director;
  Person? screenwriter;
  Person operator;
  late int _length;
  late int _goldenPalmCount;
  late int? _usaBoxOffice;
  MovieGenre genre;
  String? creatorName;
  bool? isEditable;

  Movie({
    this.id,
    required String name,
    required this.coordinates,
    this.creationDate,
    required int oscarCount,
    required double budget,
    required double totalBoxOffice,
    required this.mpaaRating,
    required this.director,
    this.screenwriter,
    required this.operator,
    required int length,
    required int goldenPalmCount,
    required int? usaBoxOffice,
    required this.genre,
    this.creatorName,
    this.isEditable,
  }) {
    this.name = name;
    this.oscarCount = oscarCount;
    this.budget = budget;
    this.totalBoxOffice = totalBoxOffice;
    this.length = length;
    this.goldenPalmCount = goldenPalmCount;
    this.usaBoxOffice = usaBoxOffice;
  }

  String get name => _name;

  set name(String name) {
    if (name.trim().isEmpty) {
      throw Exception('Поле не может быть пустым');
    }
    _name = name;
  }

  int get oscarCount => _oscarCount;

  set oscarCount(int oscarsCount) {
    if (oscarsCount <= 0) {
      throw Exception('Значение поля должно быть больше 0');
    }
    _oscarCount = oscarsCount;
  }

  double get budget => _budget;

  set budget(double budget) {
    if (budget <= 0) {
      throw Exception('Значение поля должно быть больше 0');
    }
    _budget = budget;
  }

  double get totalBoxOffice => _totalBoxOffice;

  set totalBoxOffice(double totalBoxOffice) {
    if (totalBoxOffice <= 0) {
      throw Exception('Значение поля должно быть больше 0');
    }
    _totalBoxOffice = totalBoxOffice;
  }

  int get length => _length;

  set length(int length) {
    if (length <= 0) {
      throw Exception('Значение поля должно быть больше 0');
    }
    _length = length;
  }

  int get goldenPalmCount => _goldenPalmCount;

  set goldenPalmCount(int goldenPalmCount) {
    if (goldenPalmCount <= 0) {
      throw Exception('Значение поля должно быть больше 0');
    }
    _goldenPalmCount = goldenPalmCount;
  }

  int? get usaBoxOffice => _usaBoxOffice;

  set usaBoxOffice(int? usaBoxOffice) {
    if (usaBoxOffice != null && usaBoxOffice <= 0) {
      throw Exception('Значение поля должно быть больше 0');
    }
    _usaBoxOffice = usaBoxOffice;
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: utf8.decode(latin1.encode(json['name'])),
      coordinates: Coordinates.fromJson(json['coordinates']),
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
      oscarCount: json['oscarCount'],
      budget: json['budget'],
      totalBoxOffice: json['totalBoxOffice'],
      mpaaRating: MpaaRating.values.firstWhere(
              (e) => e.toString() == 'MpaaRating.${json['mpaaRating']}'),
      director: Person.fromJson(json['director']),
      screenwriter: json['screenwriter'] != null
          ? Person.fromJson(json['screenwriter'])
          : null,
      operator: Person.fromJson(json['operator']),
      length: json['length'],
      goldenPalmCount: json['goldenPalmCount'],
      usaBoxOffice: json['usaBoxOffice'],
      genre: MovieGenre.values
          .firstWhere((e) => e.toString() == 'MovieGenre.${json['genre']}'),
      creatorName: json['creatorName'],
      isEditable: json['isEditable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coordinates': coordinates.toJson(),
      'creationDate': creationDate?.toIso8601String(),
      'oscarCount': oscarCount,
      'budget': budget,
      'totalBoxOffice': totalBoxOffice,
      'mpaaRating': mpaaRating.toString().split('.').last,
      'director': director.toJson(),
      'screenwriter': screenwriter?.toJson(),
      'operator': operator.toJson(),
      'length': length,
      'goldenPalmCount': goldenPalmCount,
      'usaBoxOffice': usaBoxOffice,
      'genre': genre.toString().split('.').last,
      'isEditable': isEditable,
    };
  }
}

class Person {
  late String _name;
  Color eyeColor;
  Color hairColor;
  Location? location;
  late String _passportID;
  Country nationality;
  String? creatorName;
  bool? isEditable;

  Person({
    required String name,
    required this.eyeColor,
    required this.hairColor,
    required this.location,
    required this.nationality,
    required String passportID,
    this.creatorName,
    this.isEditable,
  }) {
    this.name = name;
    this.passportID = passportID;
  }

  String get name => _name;

  set name(String name) {
    if (name.trim().isEmpty) {
      throw Exception('Поле не может быть пустым');
    }
    _name = name;
  }

  String get passportID => _passportID;

  set passportID(String passportID) {
    if (passportID.trim().isEmpty) {
      throw Exception('Значение поля не может быть пустым');
    }
    if (passportID.length >= 34) {
      throw Exception('Длина поля должно быть не больше 34');
    }
    _passportID = passportID;
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: utf8.decode(latin1.encode(json['name'])),
      eyeColor: Color.values
          .firstWhere((e) => e.toString() == 'Color.${json['eyeColor']}'),
      hairColor: Color.values
          .firstWhere((e) => e.toString() == 'Color.${json['hairColor']}'),
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      nationality: Country.values
          .firstWhere((e) => e.toString() == 'Country.${json['nationality']}'),
      passportID: json['passportID'],
      creatorName: json['creatorName'],
      isEditable: json['isEditable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'eyeColor': eyeColor.toString().split('.').last,
      'hairColor': hairColor.toString().split('.').last,
      'location': location?.toJson(),
      'passportID': passportID,
      'nationality': nationality.toString().split('.').last,
      'isEditable': isEditable,
    };
  }
}

class Coordinates {
  late double _x;
  int y;

  Coordinates(double x, this.y) {
    this.x = x;
  }

  double get x => _x;

  set x(double x) {
    if (x <= -946) {
      throw Exception('Значение поля должен быть больше -946');
    }
    _x = x;
  }

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      json['x'],
      json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}

class Location {
  int x;
  int y;
  double z;

  Location(this.x, this.y, this.z);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      json['x'],
      json['y'],
      json['z'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'z': z,
    };
  }
}

enum MpaaRating {
  G,
  PG_13,
  NC_17,
}

enum MovieGenre {
  ACTION,
  WESTERN,
  FANTASY,
}

enum Country {
  RUSSIA,
  INDIA,
  JAPAN;
}

enum Color {
  RED,
  BLACK,
  WHITE;
}
