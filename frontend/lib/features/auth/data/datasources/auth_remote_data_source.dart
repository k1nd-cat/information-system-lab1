import 'package:frontend/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSource({required this.client});

  Future<UserModel> login(String login, String password) async {
    final response = await client.post(
      Uri.parse('http://localhost:8080/authentication/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'login': login,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}
