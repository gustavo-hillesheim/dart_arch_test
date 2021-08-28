import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/models/dart_parameter.dart';
import 'package:arch_test/src/core/models/enums/parameter_kind.dart';

class DartParameterFactory {
  final DartTypeFactory typeFactory;

  DartParameterFactory(this.typeFactory);

  DartParameter fromParameterMirror(ParameterMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    return DartParameter(
      name: simpleName,
      type: typeFactory.fromTypeMirror(mirror.type),
      isFinal: mirror.isFinal,
      isConst: mirror.isConst,
      hasDefaultValue: mirror.hasDefaultValue,
      kind: parameterKindFromMirror(mirror),
    );
  }
}
