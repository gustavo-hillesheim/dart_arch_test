import 'dart:mirrors';

import 'package:arch_test/src/core/mappers/type_mirror_mapper.dart';
import 'package:arch_test/src/core/models/dart_parameter.dart';
import 'package:arch_test/src/core/models/enums/parameter_kind.dart';
import 'package:arch_test/src/core/utils/mirror_utils.dart';

class ParameterMirrorMapper {
  final TypeMirrorMapper typeMirrorMapper;

  ParameterMirrorMapper(this.typeMirrorMapper);

  DartParameter toDartParameter(ParameterMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    return DartParameter(
      name: simpleName,
      location: MirrorUtils.toElementLocation(mirror.location),
      type: typeMirrorMapper.toDartType(mirror.type),
      isFinal: mirror.isFinal,
      isConst: mirror.isConst,
      hasDefaultValue: mirror.hasDefaultValue,
      kind: parameterKindFromMirror(mirror),
    );
  }
}
