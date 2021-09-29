import 'dart:mirrors';

import 'paremeter_mirror_mapper.dart';
import 'type_mirror_mapper.dart';
import '../models/dart_method.dart';
import '../models/enums/constructor_kind.dart';
import '../models/enums/method_kind.dart';
import '../utils/mirror_utils.dart';

class MethodMirrorMapper {
  static late MethodMirrorMapper instance = MethodMirrorMapper(
    TypeMirrorMapper.instance,
    ParameterMirrorMapper.instance,
  );

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
        metadata: MirrorUtils.readMetadata(mirror),
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
      metadata: MirrorUtils.readMetadata(mirror),
    );
  }
}
