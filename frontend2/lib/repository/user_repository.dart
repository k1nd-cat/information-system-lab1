import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/urls.dart';
import '../viewmodel/localstorage_manager.dart';

class UserRepository {
  @Deprecated('Использовать функцию из [getWaitingAdminUsernames]')
  Future<List<String>> getWaitingAdminUsernames() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$url/user/waiting-admin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<String>.from(data);
    } else {
      throw Exception('Невозможно отобразить список пользователей');
    }
  }

  @Deprecated('Использовать функцию из [getWaitingAdminUsernames]')
  Future<void> approveAdminByUsername(String username) async {
    final token = await getToken();
    await http.post(Uri.parse('$url/user/approve-admin'),
      headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      },
      body: json.encode({'username': username}),
    );
  }

  @Deprecated('Использовать функцию из [getWaitingAdminUsernames]')
  Future<void> rejectAdminByUsername(String username) async {
    final token = await getToken();
    await http.post(Uri.parse('$url/user/reject-admin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'username': username}),
    );
  }


}
