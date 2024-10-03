class UserModel {
  final String login;
  final String token;
  final bool? isAdminApproved;

  UserModel({
    required this.login,
    required this.token,
    required this.isAdminApproved,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      token: json['token'],
      isAdminApproved: json['isAdminApproved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'token': token,
      'isAdminApproved': isAdminApproved,
    };
  }
}
