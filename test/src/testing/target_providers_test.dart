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
      DartMethod(name: 'main', returnType: DartType.voidType()),
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
    ]);
  });

  test('should return all libraries in the package', () {
    expect(
      Filters.libraries(createSamplePackage()),
      [createSampleLibrary()],
    );
  });
}
