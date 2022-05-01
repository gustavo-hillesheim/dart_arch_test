import 'package:arch_test/core.dart';
import 'package:arch_test/src/core/mappers/dart_variable_mapper.dart';
import 'package:test/test.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartVariableMapper mapper;

  setUp(() {
    mapper = DartVariableMapper.instance;
  });

  test('should create DartVariable from VariableMirror', () {
    final variableMirror = FakeVariableMirror(
      'imAVariable',
      type: DartVariable,
    );

    final dartVariable = mapper.toDartVariable(variableMirror);

    expect(
      dartVariable,
      DartVariable(
        name: 'imAVariable',
        location: ElementLocation.unknown(),
        type: DartType(
          name: 'DartVariable',
          location: ElementLocation(
            uri: 'package:arch_test/src/core/models/dart_variable.dart',
            column: 1,
            line: 1,
          ),
          parentRef: DartElementRef<DartLibrary>(
            name: 'src/core/models/dart_variable.dart',
            location: ElementLocation(
              uri: 'package:arch_test/src/core/models/dart_variable.dart',
              column: 1,
              line: 1,
            ),
          ),
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

    final dartVariable = mapper.toDartVariable(variableMirror);

    expect(
      dartVariable,
      DartVariable(
        name: '_variable',
        location: ElementLocation.unknown(),
        isFinal: true,
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

    final dartVariable = mapper.toDartVariable(variableMirror);

    expect(
      dartVariable,
      DartVariable(
        name: 'MY_CONST',
        location: ElementLocation.unknown(),
        isConst: true,
        isStatic: true,
        type: intDartType,
      ),
    );
  });
}
