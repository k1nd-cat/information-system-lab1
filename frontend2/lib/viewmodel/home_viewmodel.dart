import 'package:flutter/cupertino.dart';
import 'package:frontend2/repository/user_repository.dart';
import 'package:frontend2/repository/admin_repository.dart';

class HomeViewModel with ChangeNotifier {
  final UserRepository userRepository;
  final UserRepository adminRepository;
  String? errorMessage;
  String? message;

  HomeViewModel({
    required this.userRepository,
    required this.adminRepository,
  });

  Future<List<String>> getWaitingAdminUsernames() async {
    try {
      List<String> usernames =
          await adminRepository.getWaitingAdminUsernames();
      return usernames;
    } catch (e) {
      errorMessage = e.toString();
      return [];
    }
  }

  Future<void> approveAdminByUsername(String username) async {
    adminRepository.approveAdminByUsername(username);
  }

  Future<void> rejectAdminByUsername(String username) async {
    adminRepository.rejectAdminByUsername(username);
  }
}
