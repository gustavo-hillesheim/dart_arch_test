import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/models/dart_variable.dart';

class DartVariableFactory {
  final DartTypeFactory typeFactory;

  DartVariableFactory(this.typeFactory);

  DartVariable fromVariableMirror(VariableMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    return DartVariable(
      name: simpleName,
      isConst: mirror.isConst,
      isFinal: mirror.isFinal,
      isPrivate: mirror.isPrivate,
      isStatic: mirror.isStatic,
      type: typeFactory.fromTypeMirror(mirror.type),
    );
  }
}
