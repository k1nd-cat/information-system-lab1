import 'dart:convert';

import 'package:frontend2/dto/movies_page_request.dart';
import 'package:frontend2/model/page_movies.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../model/movies.dart';
import '../viewmodel/localstorage_manager.dart';

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

  Future<void> create(String token, Movie movie) async {
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

  Future<void> update(String token, Movie movie) async {
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

  Future<void> delete(Movie movie) async {
    var token = await getToken();
    final response = await http.post(
      Uri.parse('$url/movie/delete'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(movie.toJson()),
    );

    if (response.statusCode == 200) {

    } else {

    }
  }

  @Deprecated('Лучше пользоваться методом [getMoviesPage]')
  Future<List<Movie>> getMovies(int page, int size) async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$url/movie/get?page=$page&size=$size'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
        return data.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Exception('Не удалось загрузить фильмы');
    }
  }

  Future<MoviesPage> getMoviesPage(MoviesPageRequest request) async {
    var token = await getToken();
    var response = await http.post(
      Uri.parse('$url/movie/movies-page'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return MoviesPage.fromJson(data);
    } else {
      var errorMessage = json.decode(response.body);
      throw Exception(errorMessage['error']);
    }
  }

  Future<List<Person>> showOperatorWithZeroOscar() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$url/person/with-zero-oscar-count'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((item) => Person.fromJson(item)).toList();
    } else {
      throw Exception('Не удаётся загрузить пользователей');
    }
  }

  Future<Movie> getById(int id) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$url/movie/get-by-id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {'id': id}
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Не удалось найти фильм');
    }
  }

  Future<String> updateOscars(int count) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$url/movie/add-oscar'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
          {'value': count}
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Не получилось добавить оскары');
    }
  }
}
