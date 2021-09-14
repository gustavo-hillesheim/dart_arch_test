import 'package:arch_test/src/core/models/element_location.dart';
import 'package:arch_test/src/core/models/models.dart';
import 'package:arch_test/src/testing/target_providers.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../mock/models.dart';

void main() {
  test('should return all classes in the package', () {
    expect(
      Filters.classes(createSamplePackage()),
      [
        createTestClass(),
      ],
    );
  });

  test('should return all methods from the package', () {
    expect(Filters.methods(createSamplePackage()), [
      DartMethod(
        name: 'main',
        returnType: DartType.voidType(),
        location: ElementLocation.unknown(),
        parentRef: DartElementRef<DartLibrary>(
          name: 'main.dart',
          location: ElementLocation.unknown(),
        ),
        parameters: [],
      ),
      DartConstructor(
        name: 'TestClass',
        location: ElementLocation.unknown(),
        parentRef: DartElementRef<DartClass>(
          name: 'TestClass',
          location: ElementLocation.unknown(),
        ),
        parameters: [],
        returnType: DartType(
          name: 'TestClass',
          generics: [],
          location: ElementLocation.unknown(),
          parentRef: DartElementRef<DartLibrary>(
            name: 'main.dart',
            location: ElementLocation.unknown(),
          ),
        ),
        constructorKind: ConstructorKind.GENERATIVE,
      ),
      DartMethod(
        name: 'setId',
        returnType: DartType.voidType(),
        parameters: [],
        location: ElementLocation.unknown(),
        parentRef: DartElementRef<DartClass>(
          name: 'TestClass',
          location: ElementLocation.unknown(),
        ),
      ),
    ]);
  });

  test('should return all libraries in the package', () {
    expect(
      Filters.libraries(createSamplePackage()),
      [createSampleLibrary()],
    );
  });
}
