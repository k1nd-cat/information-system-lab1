class FieldValidationException implements Exception {
  final Map<String, String?> errors;

  FieldValidationException(this.errors);
}