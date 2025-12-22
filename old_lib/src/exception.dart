class PackageNameNotFoundException implements Exception {
  final String message;

  PackageNameNotFoundException(this.message);

  @override
  String toString() {
    return 'PackageNameNotFoundException($message)';
  }
}

class PackageNotFoundException implements Exception {
  final String message;

  PackageNotFoundException(this.message);

  @override
  String toString() {
    return 'PackageNotFoundException($message)';
  }
}
