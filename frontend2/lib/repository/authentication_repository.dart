import 'dart:convert';

import 'package:frontend2/constants/urls.dart';
import 'package:frontend2/dto/user_dto.dart';
import 'package:http/http.dart' as http;

import '../exceptions/field_validation_exception.dart';
import '../model/user.dart';

class AuthenticationRepository {
  Future<AuthResponse> checkToken(String token) async {
    final response = await http.post(
      Uri.parse('$url/auth/check-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(json.decode(response.body));
    } else {
      if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        if (errorData['fieldErrors'] != null) {
          // Предполагаем, что сервер возвращает поле `fieldErrors` с ошибками по полям
          throw FieldValidationException({
            'username': errorData['fieldErrors']['username'],
            'password': errorData['fieldErrors']['password'],
          });
        } else {
          throw Exception(errorData['message'] ?? 'Неизвестная ошибка');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Неавторизованный доступ');
      } else if (response.statusCode == 500) {
        throw Exception('Ошибка сервера');
      } else {
        throw Exception('Неизвестная ошибка с кодом ${response.statusCode}');
      }
    }
  }

  Future<AuthResponse> signUp(SignUpRequest request) async {
    final response = await http.post(
      Uri.parse('$url/auth/sign-up'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        if (errorData['username'] != null || errorData['password'] != null) {
          throw FieldValidationException({
            'username': errorData['username'] != null ? utf8.decode(latin1.encode(errorData['username'])) : null,
            'password': errorData['password'] != null ? utf8.decode(latin1.encode(errorData['password'])) : null,
          });
        } else {
          throw Exception(errorData['message'] ?? 'Неизвестная ошибка');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Неавторизованный доступ');
      } else if (response.statusCode == 500) {
        throw Exception('Ошибка сервера');
      } else {
        throw Exception('Неизвестная ошибка с кодом ${response.statusCode}');
      }
    }
  }

  Future<AuthResponse> signIn(SignInRequest request) async {
    final response = await http.post(
      Uri.parse('$url/auth/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        if (errorData['username'] != null || errorData['password'] != null) {
          // Предполагаем, что сервер возвращает поле `fieldErrors` с ошибками по полям
          throw FieldValidationException({
            'username': errorData['username'],
            'password': errorData['password'],
          });
        } else {
          throw Exception(errorData['message'] ?? 'Неизвестная ошибка');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Неавторизованный доступ');
      } else if (response.statusCode == 500) {
        throw Exception('Ошибка сервера');
      } else {
        throw Exception('Неизвестная ошибка с кодом ${response.statusCode}');
      }
    }
  }
  
  Future<bool> setWaitingAdmin(User user) async {
    final response = await http.get(
      Uri.parse('$url/user/request-admin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.token}'
      }
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }


}
