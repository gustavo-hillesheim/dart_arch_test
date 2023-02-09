import 'package:arch_test/core.dart';
import 'package:arch_test/testing.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../mock/models.dart';

void main() {
  test('should return all classes in the package', () {
    expect(
      Selectors.classes(createSamplePackage()),
      [
        createTestClass(),
      ],
    );
  });

  test('should return all enums in the package', () {
    expect(
      Selectors.enums(createSamplePackage()),
      [
        createMyEnum(),
      ],
    );
  });

  test('should return all methods from the package', () {
    expect(Selectors.methods(createSamplePackage()), [
      DartConstructor(
        name: 'TestClass',
        location: ElementLocation.unknown(),
        parentRef: DartElementRef<DartClass>(
          name: 'TestClass',
          location: ElementLocation.unknown(),
        ),
        returnType: DartType(
          name: 'TestClass',
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
      ),
    ]);
  });

  test('should return all libraries in the package', () {
    expect(
      Selectors.libraries(createSamplePackage()),
      [createSampleLibrary()],
    );
  });

  test('should return all variables in the package', () {
    expect(
      Selectors.variables(createSamplePackage()),
      [
        DartVariable(
          name: 'id',
          type: DartType.from<int>(),
          location: ElementLocation.unknown(),
          parentRef: DartElementRef<DartClass>(
            name: 'TestClass',
            location: ElementLocation.unknown(),
          ),
        ),
        DartVariable(
          name: 'someVar',
          location: ElementLocation.unknown(),
          type: DartType.from<String>(),
        ),
      ],
    );
  });

  test('should return all variables in the package', () {
    expect(
      Selectors.elements(createSamplePackage()),
      [
        createSampleLibrary(),
        createTestClass(),
        DartConstructor(
          name: 'TestClass',
          location: ElementLocation.unknown(),
          parentRef: DartElementRef<DartClass>(
            name: 'TestClass',
            location: ElementLocation.unknown(),
          ),
          returnType: DartType(
            name: 'TestClass',
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
          location: ElementLocation.unknown(),
          parentRef: DartElementRef<DartClass>(
            name: 'TestClass',
            location: ElementLocation.unknown(),
          ),
        ),
        DartVariable(
          name: 'id',
          type: DartType.from<int>(),
          location: ElementLocation.unknown(),
          parentRef: DartElementRef<DartClass>(
            name: 'TestClass',
            location: ElementLocation.unknown(),
          ),
        ),
        createMyEnum(),
        DartMethod(
          name: 'main',
          returnType: DartType.voidType(),
          location: ElementLocation.unknown(),
          parentRef: DartElementRef<DartLibrary>(
            name: 'main.dart',
            location: ElementLocation.unknown(),
          ),
        ),
        DartVariable(
          name: 'someVar',
          location: ElementLocation.unknown(),
          type: DartType.from<String>(),
        ),
      ],
    );
  });
}
