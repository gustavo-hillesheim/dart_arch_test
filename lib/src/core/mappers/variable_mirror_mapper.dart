import 'dart:mirrors';

import 'package:arch_test/src/core/mappers/type_mirror_mapper.dart';
import 'package:arch_test/src/core/models/dart_variable.dart';
import 'package:arch_test/src/core/utils/mirror_utils.dart';

class VariableMirrorMapper {
  final TypeMirrorMapper typeMirrorMapper;

  VariableMirrorMapper(this.typeMirrorMapper);

  DartVariable toDartVariable(VariableMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    return DartVariable(
      name: simpleName,
      isConst: mirror.isConst,
      isFinal: mirror.isFinal,
      isPrivate: mirror.isPrivate,
      isStatic: mirror.isStatic,
      location: MirrorUtils.elementLocation(mirror),
      type: typeMirrorMapper.toDartType(mirror.type),
    );
  }
}
