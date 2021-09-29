import 'dart:mirrors';

import 'package:arch_test/core/mappers/type_mirror_mapper.dart';
import 'package:arch_test/core/models/dart_method.dart';
import 'package:arch_test/core/models/dart_parameter.dart';
import 'package:arch_test/core/models/enums/parameter_kind.dart';
import 'package:arch_test/core/utils/mirror_utils.dart';

class ParameterMirrorMapper {
  static late ParameterMirrorMapper instance =
      ParameterMirrorMapper(TypeMirrorMapper.instance);

  final TypeMirrorMapper typeMirrorMapper;

  ParameterMirrorMapper(this.typeMirrorMapper);

  DartParameter toDartParameter(ParameterMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    return DartParameter(
      name: simpleName,
      parentRef: MirrorUtils.elementRef<DartMethod>(mirror.owner),
      type: typeMirrorMapper.toDartType(mirror.type),
      isFinal: mirror.isFinal,
      isConst: mirror.isConst,
      hasDefaultValue: mirror.hasDefaultValue,
      kind: parameterKindFromMirror(mirror),
      metadata: MirrorUtils.readMetadata(mirror),
    );
  }
}
