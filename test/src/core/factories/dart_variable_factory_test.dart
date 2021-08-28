import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/factories/dart_variable_factory.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/dart_variable.dart';
import 'package:test/test.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartVariableFactory factory;

  setUp(() {
    factory = DartVariableFactory(DartTypeFactory());
  });

  test('should create DartVariable from VariableMirror', () {
    final variableMirror = FakeVariableMirror(
      'imAVariable',
      type: DartVariable,
    );

    final dartVariable = factory.fromVariableMirror(variableMirror);

    expect(
      dartVariable,
      DartVariable(
        name: 'imAVariable',
        isFinal: false,
        isConst: false,
        isPrivate: false,
        isStatic: false,
        type: DartType(
          name: 'DartVariable',
          package: 'arch_test',
          library: 'package:arch_test/src/core/models/dart_variable.dart',
        ),
      ),
    );
  });

  test('should create DartVariable from final private VariableMirror', () {
    final variableMirror = FakeVariableMirror(
      '_variable',
      type: double,
      isFinal: true,
      isPrivate: true,
    );

    final dartVariable = factory.fromVariableMirror(variableMirror);

    expect(
      dartVariable,
      DartVariable(
        name: '_variable',
        isFinal: true,
        isConst: false,
        isPrivate: true,
        isStatic: false,
        type: doubleDartType,
      ),
    );
  });

  test('should create DartVariable from static const VariableMirror', () {
    final variableMirror = FakeVariableMirror(
      'MY_CONST',
      type: int,
      isStatic: true,
      isConst: true,
    );

    final dartVariable = factory.fromVariableMirror(variableMirror);

    expect(
      dartVariable,
      DartVariable(
        name: 'MY_CONST',
        isFinal: false,
        isConst: true,
        isPrivate: false,
        isStatic: true,
        type: intDartType,
      ),
    );
  });
}
