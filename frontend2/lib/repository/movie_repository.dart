import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../model/movies.dart';

class MovieRepository {
  Future<List<Person>> getAllPersons(String token) async {
    final response = await http.get(
      Uri.parse('$url/person/get-all'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      return data.map((item) => Person.fromJson(item)).toList();
    } else {
      throw Exception('Не удалось загрузить Person');
    }
  }

  Future<void> create(String token, Movies movie) async {
    final response = await http.post(
      Uri.parse('$url/movie/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(movie.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Не удалось создать фильм');
    }
  }

  Future<void> update(String token, Movies movie) async {
    final response = await http.post(
      Uri.parse('$url/movie/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(movie.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Не удалось обновить фильм');
    }
  }
}
