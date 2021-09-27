import 'dart:mirrors';

import 'package:arch_test/core/mappers/paremeter_mirror_mapper.dart';
import 'package:arch_test/core/mappers/type_mirror_mapper.dart';
import 'package:arch_test/core/models/dart_method.dart';
import 'package:arch_test/core/models/enums/constructor_kind.dart';
import 'package:arch_test/core/models/enums/method_kind.dart';
import 'package:arch_test/core/utils/mirror_utils.dart';

class MethodMirrorMapper {
  static MethodMirrorMapper? _instance;
  static MethodMirrorMapper get instance {
    _instance ??= MethodMirrorMapper(
      TypeMirrorMapper.instance,
      ParameterMirrorMapper.instance,
    );
    return _instance!;
  }

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
        parentRef: MirrorUtils.elementRef(mirror.owner),
        returnType: returnType,
        parameters: parameters,
        constructorKind: constructorKindFromMirror(mirror),
      );
    }
    return DartMethod(
      name: simpleName,
      kind: methodKindFromMirror(mirror),
      parentRef: MirrorUtils.elementRef(mirror.owner),
      location: location,
      returnType: returnType,
      isTopLevel: mirror.isTopLevel,
      isAbstract: mirror.isAbstract,
      isStatic: mirror.isStatic,
      parameters: parameters,
    );
  }
}
