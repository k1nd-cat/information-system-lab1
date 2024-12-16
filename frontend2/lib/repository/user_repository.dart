import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/urls.dart';

class UserRepository {
  Future<List<String>> getWaitingAdminUsernames(String token) async {
    final response = await http.get(
      Uri.parse('$url/user/waiting-admin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<String>.from(data['usernames']);
    } else {
      throw Exception('Невозможно отобразить список пользователей');
    }
  }

  Future<void> approveAdminByUsername(String token, String username) async {
    await http.post(Uri.parse('$url/user/approve-admin'),
      headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      },
      body: json.encode({'username': username}),
    );
  }

  Future<void> rejectAdminByUsername(String token, String username) async {
    await http.post(Uri.parse('$url/user/reject-admin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'username': username}),
    );
  }


}
