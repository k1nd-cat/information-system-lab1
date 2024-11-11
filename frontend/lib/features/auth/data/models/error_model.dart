class ErrorModel {
  String? otherError;
  String? loginError;
  String? passwordError;

  ErrorModel({
    String? error,
    this.loginError,
    this.passwordError,
  }) : otherError = error;

  @override
  String toString() {
    return otherError ?? "";
  }
}
