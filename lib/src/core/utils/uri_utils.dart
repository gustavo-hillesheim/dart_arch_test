import 'dart:mirrors';

class UriUtils {
  static String getPackageName(Uri uri) {
    return getPackageNameFromString(uri.toString());
  }

  static String getPackageNameFromString(String uri) {
    final path = uri.replaceFirst('package:', '');
    if (path.contains('/')) {
      return path.substring(0, path.indexOf('/'));
    }
    return path;
  }

  static String getLibraryPathFromSourceLocation(SourceLocation? location) {
    if (location != null) {
      return getLibraryPath(location.sourceUri.toString());
    }
    return 'unknown';
  }

  static String getLibraryPath(String uri, [String? package]) {
    final packageName = package ?? getPackageNameFromString(uri);
    return uri.replaceFirst('package:$packageName/', '');
  }
}
