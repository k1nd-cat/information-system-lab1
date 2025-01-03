import '../model/user.dart';

class SignUpRequest {
  String username;
  String password;
  bool isWaitingAdmin;

  SignUpRequest({
    required this.username,
    required this.password,
    required this.isWaitingAdmin,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'isWaitingAdmin': isWaitingAdmin,
    };
  }
}

class SignInRequest {
  String username;
  String password;

  SignInRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class UpdatedRoleResponse {
  Role role;
  bool isWaitingAdmin;
  String token;

  UpdatedRoleResponse({
    required this.role,
    required this.isWaitingAdmin,
    required this.token,
  });

  factory UpdatedRoleResponse.fromJson(Map<String, dynamic> json) {
    return UpdatedRoleResponse(
      role: RoleParsing.fromJson(json['role']),
      isWaitingAdmin: json['isWaitingAdmin'],
      token: json['token'],
    );
  }
}

class AuthResponse {
  String token;
  Role role;
  String username;
  bool isWaitingAdmin;

  AuthResponse({
    required this.token,
    required this.role,
    required this.username,
    required this.isWaitingAdmin,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      role: RoleParsing.fromJson(json['role']),
      username: json['username'],
      isWaitingAdmin: json['isWaitingAdmin'] as bool,
    );
  }
}

extension RoleParsing on Role {
  static Role fromJson(String value) {
    return Role.values.firstWhere((e) => e.toString().split('.').last == value);
  }
}
