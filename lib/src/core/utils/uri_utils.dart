class UriUtils {
  static String getPackageName(Uri uri) {
    final path = uri.toString().replaceFirst('package:', '');
    final package = path.substring(0, path.indexOf('/'));
    return package;
  }
}
