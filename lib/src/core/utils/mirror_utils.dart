import 'dart:mirrors';

import 'package:arch_test/src/core/models/element_location.dart';

class MirrorUtils {
  static ElementLocation toElementLocation(SourceLocation? sourceLocation) {
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
