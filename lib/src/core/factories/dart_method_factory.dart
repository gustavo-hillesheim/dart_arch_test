import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_parameter_factory.dart';
import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:arch_test/src/core/models/enums/method_kind.dart';

class DartMethodFactory {
  final DartTypeFactory typeFactory;
  final DartParameterFactory parameterFactory;

  DartMethodFactory(this.typeFactory, this.parameterFactory);

  DartMethod fromMethodMirror(MethodMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    final parameters = mirror.parameters
        .map(parameterFactory.fromParameterMirror)
        .toList(growable: false);
    return DartMethod(
        name: simpleName,
        kind: methodKindFromMirror(mirror),
        returnType: typeFactory.fromTypeMirror(mirror.returnType),
        constructorKind:
            mirror.isConstructor ? constructorKindFromMirror(mirror) : null,
        isAbstract: mirror.isAbstract,
        isStatic: mirror.isStatic,
        parameters: parameters);
  }
}
