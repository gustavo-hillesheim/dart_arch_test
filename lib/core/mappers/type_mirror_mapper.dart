import 'dart:mirrors';

import 'package:arch_test/core/models/dart_type.dart';
import 'package:arch_test/core/utils/mirror_utils.dart';

class TypeMirrorMapper {
  static TypeMirrorMapper? _instance;
  static TypeMirrorMapper get instance {
    _instance ??= TypeMirrorMapper();
    return _instance!;
  }

  const TypeMirrorMapper();

  DartType toDartType(TypeMirror mirror) {
    final name = MirrorSystem.getName(mirror.simpleName);
    final generics = mirror.typeArguments.map(toDartType).toList();
    return DartType(
      name: name,
      generics: generics,
      location: MirrorUtils.elementLocation(mirror),
      parentRef: MirrorUtils.elementRef(mirror.owner),
    );
  }
}