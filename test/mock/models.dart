import 'package:arch_test/src/core/core.dart';

DartPackage createSamplePackage() {
  return DartPackage(
    name: 'test_pkg',
    libraries: [createSampleLibrary()],
  );
}

DartLibrary createSampleLibrary() {
  return DartLibrary(
    name: 'main.dart',
    package: 'test_pkg',
    classes: [
      createTestClass(),
    ],
    methods: [
      DartMethod(name: 'main', returnType: DartType.voidType()),
    ],
  );
}

DartClass createTestClass() {
  return DartClass(
    name: 'TestClass',
    library: 'main.dart',
    package: 'test_pkg',
    fields: [
      DartVariable(name: 'id', type: DartType.from(int)),
    ],
    methods: [
      DartMethod(
        name: 'TestClass',
        returnType: DartType(
          name: 'TestClass',
          library: 'main.dart',
          package: 'test_pkg',
        ),
        kind: MethodKind.CONSTRUCTOR,
        constructorKind: ConstructorKind.GENERATIVE,
      ),
      DartMethod(name: 'setId', returnType: DartType.voidType()),
    ],
  );
}
