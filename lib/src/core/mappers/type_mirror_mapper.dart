import 'dart:mirrors';

import '../models/dart_type.dart';
import '../utils/mirror_utils.dart';

class TypeMirrorMapper {
  static late TypeMirrorMapper instance = TypeMirrorMapper();

  const TypeMirrorMapper();

  DartType toDartType(TypeMirror mirror) {
    final name = MirrorSystem.getName(mirror.simpleName);
    final generics = mirror.typeArguments.map(toDartType).toList();
    return DartType(
      name: name,
      generics: generics,
      location: MirrorUtils.elementLocation(mirror),
      parentRef: MirrorUtils.elementRef(mirror.owner),
      metadata: MirrorUtils.readMetadata(mirror),
    );
  }
}
