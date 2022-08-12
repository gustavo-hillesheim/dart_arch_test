import 'package:arch_test/core.dart';
import 'package:arch_test/src/core/mappers/dart_type_mapper.dart';
import 'package:test/test.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartTypeMapper mapper;

  setUp(() {
    mapper = DartTypeMapper.instance;
  });

  test('should create DartType from TypeMirror', () {
    final typeMirror = FakeTypeMirror('MyType', 'package:pkg/my_type.dart');

    final dartType = mapper.toDartType(typeMirror);

    expect(
      dartType,
      DartType(
        name: 'MyType',
        location: ElementLocation(uri: 'package:pkg/my_type.dart'),
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
        location: ElementLocation(uri: 'dart:core/list.dart'),
        generics: [stringDartType],
        parentRef: DartElementRef<DartLibrary>(
          name: 'dart:core',
          location:
              ElementLocation(uri: 'dart:core-patch/string_buffer_patch.dart'),
        ),
      ),
    );
  });
}
