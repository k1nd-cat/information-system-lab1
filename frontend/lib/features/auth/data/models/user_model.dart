class UserModel {
  final String token;
  final bool? isAdmin;

  UserModel({
    required this.token,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      isAdmin: json['isAdmin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'isAdmin': isAdmin,
    };
  }
}
