import 'package:arch_test/core.dart';

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
    classes: [
      createTestClass(),
      createMyEnum(),
    ],
    methods: [
      DartMethod(
        name: 'main',
        returnType: DartType.voidType(),
        location: ElementLocation.unknown(),
        parentRef: DartElementRef<DartLibrary>(
          name: 'main.dart',
          location: ElementLocation.unknown(),
        ),
      ),
    ],
    variables: [
      DartVariable(
        name: 'someVar',
        location: ElementLocation.unknown(),
        type: DartType.from<String>(),
      ),
    ],
  );
}

DartClass createMyEnum() {
  return DartClass(
    name: 'MyEnum',
    isEnum: true,
    location: ElementLocation.unknown(),
    parentRef: DartElementRef<DartLibrary>(
      name: 'main.dart',
      location: ElementLocation.unknown(),
    ),
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
    fields: [
      DartVariable(
        name: 'id',
        type: DartType.from<int>(),
        location: ElementLocation.unknown(),
        parentRef: DartElementRef<DartClass>(
          name: 'TestClass',
          location: ElementLocation.unknown(),
        ),
      ),
    ],
    methods: [
      DartMethod(
        name: 'setId',
        returnType: DartType.voidType(),
        location: ElementLocation.unknown(),
        parentRef: DartElementRef<DartClass>(
          name: 'TestClass',
          location: ElementLocation.unknown(),
        ),
      ),
    ],
    constructors: [
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
    ],
  );
}
