import 'dart:mirrors';

import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/utils/uri_utils.dart';

class DartTypeFactory {
  const DartTypeFactory();

  DartType fromTypeMirror(TypeMirror mirror) {
    final name = MirrorSystem.getName(mirror.simpleName);
    final package = mirror.location != null
        ? UriUtils.getPackageName(mirror.location!.sourceUri)
        : '';
    final library = UriUtils.getLibraryPathFromSourceLocation(mirror.location);
    final generics = mirror.typeArguments.map(fromTypeMirror).toList();
    return DartType(
      name: name,
      package: package,
      library: library,
      generics: generics,
    );
  }
}
