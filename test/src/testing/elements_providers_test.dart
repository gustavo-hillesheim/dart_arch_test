import 'package:arch_test/src/core/models/element_location.dart';
import 'package:arch_test/src/core/models/models.dart';
import 'package:arch_test/src/testing/elements_provider.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../mock/models.dart';

void main() {
  test('should return all classes in the package', () {
    expect(
      ElementsProviders.classes(createSamplePackage()),
      [
        createTestClass(),
      ],
    );
  });

  test('should return all enums in the package', () {
    expect(
      ElementsProviders.enums(createSamplePackage()),
      [
        createMyEnum(),
      ],
    );
  });

  test('should return all methods from the package', () {
    expect(ElementsProviders.methods(createSamplePackage()), [
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
    ]);
  });

  test('should return all libraries in the package', () {
    expect(
      ElementsProviders.libraries(createSamplePackage()),
      [createSampleLibrary()],
    );
  });
}
