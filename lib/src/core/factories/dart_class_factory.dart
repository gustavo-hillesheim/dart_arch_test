import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/factories/dart_variable_factory.dart';
import 'package:arch_test/src/core/models/dart_class.dart';

class DartClassFactory {
  final DartVariableFactory variableFactory;
  final DartMethodFactory methodFactory;

  DartClassFactory(this.variableFactory, this.methodFactory);

  DartClass fromClassMirror(ClassMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    final fields = mirror.declarations.values
        .whereType<VariableMirror>()
        .map(variableFactory.fromVariableMirror)
        .toList(growable: false);
    final methods = mirror.declarations.values
        .whereType<MethodMirror>()
        .map(methodFactory.fromMethodMirror)
        .toList(growable: false);

    return DartClass(
      name: simpleName,
      isAbstract: mirror.isAbstract,
      isEnum: mirror.isEnum,
      fields: fields,
      methods: methods,
    );
  }
}
