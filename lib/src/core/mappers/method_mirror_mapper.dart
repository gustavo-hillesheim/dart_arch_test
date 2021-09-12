import 'dart:mirrors';

import 'package:arch_test/src/core/mappers/paremeter_mirror_mapper.dart';
import 'package:arch_test/src/core/mappers/type_mirror_mapper.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:arch_test/src/core/models/enums/method_kind.dart';
import 'package:arch_test/src/core/utils/mirror_utils.dart';

class MethodMirrorMapper {
  final TypeMirrorMapper typeMirrorMapper;
  final ParameterMirrorMapper parameterMirrorMapper;

  MethodMirrorMapper(this.typeMirrorMapper, this.parameterMirrorMapper);

  DartMethod toDartMethod(MethodMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    final parameters = mirror.parameters
        .map(parameterMirrorMapper.toDartParameter)
        .toList(growable: false);
    final location = MirrorUtils.elementLocation(mirror);
    final returnType = typeMirrorMapper.toDartType(mirror.returnType);
    if (mirror.isConstructor) {
      return DartConstructor(
        name: simpleName,
        location: location,
        returnType: returnType,
        parameters: parameters,
        constructorKind: constructorKindFromMirror(mirror),
      );
    }
    return DartMethod(
      name: simpleName,
      kind: methodKindFromMirror(mirror),
      location: location,
      returnType: returnType,
      isAbstract: mirror.isAbstract,
      isStatic: mirror.isStatic,
      parameters: parameters,
    );
  }
}
