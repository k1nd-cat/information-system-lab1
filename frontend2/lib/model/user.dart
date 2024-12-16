import '../dto/user_dto.dart';

class User {
  String username;
  String token;
  Role role;
  bool isWaitingAdmin;

  User({
    required this.username,
    required this.token,
    required this.role,
    required this.isWaitingAdmin,
  });

  factory User.fromResponse(AuthResponse response) {
    return User(
        username: response.username,
        token: response.token,
        role: response.role,
        isWaitingAdmin: response.isWaitingAdmin);
  }

  void updateRoleStatus(WebSocketResponse response) {
    isWaitingAdmin = response.isWaitingAdmin;
    role = response.role;
  }
}

enum Role {
  ROLE_ADMIN,
  ROLE_USER,
}
