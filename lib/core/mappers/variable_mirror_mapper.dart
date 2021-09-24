import 'dart:mirrors';

import 'package:arch_test/core/mappers/type_mirror_mapper.dart';
import 'package:arch_test/core/models/dart_variable.dart';
import 'package:arch_test/core/utils/mirror_utils.dart';

class VariableMirrorMapper {
  static VariableMirrorMapper? _instance;
  static VariableMirrorMapper get instance {
    _instance ??= VariableMirrorMapper(TypeMirrorMapper.instance);
    return _instance!;
  }

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
      parentRef: MirrorUtils.elementRef(mirror.owner),
      type: typeMirrorMapper.toDartType(mirror.type),
    );
  }
}
