import 'dart:mirrors';

import 'package:path/path.dart';

class UriUtils {
  static String getPackageName(Uri uri) {
    return getPackageNameFromString(uri.toString());
  }

  static String getPackageNameFromString(String uri) {
    uri = normalize(uri);
    final path = uri.replaceFirst('package:', '');
    if (path.contains(separator)) {
      return path.substring(0, path.indexOf(separator));
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
    uri = normalize(uri);
    final packageName = package ?? getPackageNameFromString(uri);
    return uri.replaceFirst('package:$packageName$separator', '');
  }
}
