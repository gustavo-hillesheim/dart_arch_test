import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/core/models/element_location.dart';

DartPackage createSamplePackage() {
  return DartPackage(
    name: 'test_pkg',
    libraries: [createSampleLibrary()],
  );
}

DartLibrary createSampleLibrary() {
  return DartLibrary(
    name: 'main.dart',
    location: ElementLocation.unknown(),
    parentRef: null,
    classes: [
      createTestClass(),
    ],
    dependencies: [],
    methods: [
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
    ],
  );
}

DartClass createTestClass() {
  return DartClass(
    name: 'TestClass',
    location: ElementLocation.unknown(),
    parentRef: DartElementRef<DartLibrary>(
      name: 'main.dart',
      location: ElementLocation.unknown(),
    ),
    generics: [],
    superInterfaces: [],
    fields: [
      DartVariable(
        name: 'id',
        type: DartType.from(int),
        location: ElementLocation.unknown(),
        parentRef: DartElementRef<DartClass>(
          name: 'TestClass',
          location: ElementLocation.unknown(),
        ),
      ),
    ],
    methods: [
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
    ],
  );
}
