import 'package:arch_test/core/core.dart';
import 'package:arch_test/core/models/dart_type.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

import '../../mock/mirror_system.dart';

void main() {
  late TypeMirrorMapper mapper;

  setUp(() {
    mapper = TypeMirrorMapper.instance;
  });

  test('should create DartType from TypeMirror', () {
    final typeMirror = FakeTypeMirror('MyType', 'package:pkg/my_type.dart');

    final dartType = mapper.toDartType(typeMirror);

    expect(
      dartType,
      DartType(
        name: 'MyType',
        generics: [],
        location: ElementLocation(
          uri: 'package:pkg/my_type.dart',
          column: 1,
          line: 1,
        ),
        parentRef: null,
      ),
    );
  });

  test('should create DartType with generics from TypeMirror', () {
    final typeMirror = FakeTypeMirror.fromType(List, typeArguments: [String]);

    final dartType = mapper.toDartType(typeMirror);

    expect(
      dartType,
      DartType(
        name: 'List',
        location: ElementLocation(
          uri: 'dart:core/list.dart',
          column: 1,
          line: 1,
        ),
        generics: [stringDartType],
        parentRef: DartElementRef<DartLibrary>(
          name: 'dart:core',
          location: ElementLocation(
            uri: 'dart:core-patch/string_buffer_patch.dart',
            column: 1,
            line: 1,
          ),
        ),
      ),
    );
  });
}
