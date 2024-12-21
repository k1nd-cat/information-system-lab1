import 'package:flutter/cupertino.dart';
import 'package:frontend2/repository/user_repository.dart';

class HomeViewModel with ChangeNotifier {
  final UserRepository repository;

  HomeViewModel(this.repository);

  Future<List<String>> getWaitingAdminUsernames(String token) async {
    try {
      List<String> usernames = await repository.getWaitingAdminUsernames(token);
      return usernames;
    } catch (e) {
      throw Exception('No data available');
    }
  }

  Future<void> approveAdminByUsername(String token, String username) async {
    repository.approveAdminByUsername(token, username);
  }

  Future<void> rejectAdminByUsername(String token, String username) async {
    repository.rejectAdminByUsername(token, username);
  }

}