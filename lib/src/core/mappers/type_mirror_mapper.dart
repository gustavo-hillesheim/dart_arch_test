import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/utils/mirror_utils.dart';

class TypeMirrorMapper {
  const TypeMirrorMapper();

  DartType toDartType(TypeMirror mirror) {
    final name = MirrorSystem.getName(mirror.simpleName);
    final generics = mirror.typeArguments.map(toDartType).toList();
    return DartType(
      name: name,
      generics: generics,
      location: MirrorUtils.toElementLocation(mirror.location),
    );
  }
}
