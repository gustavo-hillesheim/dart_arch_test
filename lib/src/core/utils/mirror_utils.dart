import 'dart:mirrors';

import 'package:arch_test/src/core/models/element_location.dart';

class MirrorUtils {
  static ElementLocation dependencyElementLocation(
      LibraryDependencyMirror mirror) {
    try {
      return _elementLocation(mirror.location);
    } on UnsupportedError {
      return ElementLocation.unknown();
    }
  }

  static ElementLocation elementLocation(DeclarationMirror mirror) {
    try {
      return _elementLocation(mirror.location);
    } on UnsupportedError {
      return ElementLocation.unknown();
    }
  }

  static ElementLocation _elementLocation(SourceLocation? sourceLocation) {
    if (sourceLocation == null) {
      return ElementLocation.unknown();
    }

    return ElementLocation(
      uri: sourceLocation.sourceUri.toString(),
      column: sourceLocation.column,
      line: sourceLocation.line,
    );
  }
}
