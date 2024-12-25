import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../viewmodel/localstorage_manager.dart';

class AdminRepository {
  Future<List<String>> getWaitingAdminUsernames() async {
    final token = await getToken();
    final response =
        await http.get(Uri.parse('$url/admin/waiting-admin'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<String>.from(data);
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      throw Exception(errorData['error']);
    }
  }

  Future<String> approveAdminByUsername(String username) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$url/admin/approve-admin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'username': username}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['message'];
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      throw Exception(errorData['error']);
    }
  }

  Future<void> rejectAdminByUsername(String username) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$url/admin/reject-admin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'username': username}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['message'];
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      throw Exception(errorData['error']);
    }
  }
}
