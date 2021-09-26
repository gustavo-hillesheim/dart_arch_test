class UnsupportedValidationException implements Exception {
  final String message;

  UnsupportedValidationException(this.message);

  @override
  String toString() {
    return 'UnsupportedValidationException($message)';
  }
}
