import 'package:arch_test/core/core.dart';
import 'package:arch_test/core/models/dart_type.dart';
import 'package:arch_test/core/models/dart_variable.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:test/test.dart';

import '../../mock/mirror_system.dart';

void main() {
  late VariableMirrorMapper mapper;

  setUp(() {
    mapper = VariableMirrorMapper.instance;
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
        parentRef: null,
        type: DartType(
          name: 'DartVariable',
          generics: [],
          location: ElementLocation(
            uri: 'package:arch_test/core/models/dart_variable.dart',
            column: 1,
            line: 1,
          ),
          parentRef: DartElementRef<DartLibrary>(
            name: 'core/models/dart_variable.dart',
            location: ElementLocation(
              uri: 'package:arch_test/core/models/dart_variable.dart',
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
        parentRef: null,
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
        parentRef: null,
        isConst: true,
        isStatic: true,
        type: intDartType,
      ),
    );
  });
}
