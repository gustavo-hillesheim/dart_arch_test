import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/mappers/method_mirror_mapper.dart';
import 'package:arch_test/src/core/mappers/type_mirror_mapper.dart';
import 'package:arch_test/src/core/mappers/variable_mirror_mapper.dart';
import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/utils/mirror_utils.dart';

class ClassMirrorMapper {
  final VariableMirrorMapper variableMirrorMapper;
  final MethodMirrorMapper methodMirrorMapper;
  final TypeMirrorMapper typeMirrorMapper;

  ClassMirrorMapper(this.variableMirrorMapper, this.methodMirrorMapper,
      this.typeMirrorMapper);

  DartClass toDartClass(ClassMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    final fields = mirror.declarations.values
        .whereType<VariableMirror>()
        .map(variableMirrorMapper.toDartVariable)
        .toList(growable: false);
    final methods = mirror.declarations.values
        .whereType<MethodMirror>()
        .map(methodMirrorMapper.toDartMethod)
        .toList(growable: false);
    final superClass = mirror.superclass != null &&
            (!mirror.superclass!.hasReflectedType ||
                mirror.superclass!.reflectedType != Object)
        ? toDartClass(mirror.superclass!)
        : null;
    final superInterfaces = mirror.superinterfaces.map(toDartClass).toList();
    final generics =
        mirror.typeArguments.map(typeMirrorMapper.toDartType).toList();

    return DartClass(
      name: simpleName,
      location: MirrorUtils.elementLocation(mirror),
      parentRef: MirrorUtils.elementRef<DartLibrary>(mirror.owner),
      generics: generics,
      isAbstract: mirror.isAbstract,
      isEnum: mirror.isEnum,
      fields: fields,
      methods: methods,
      superClass: superClass,
      superInterfaces: superInterfaces,
    );
  }
}
