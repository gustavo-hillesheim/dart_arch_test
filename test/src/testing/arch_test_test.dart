import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/testing/arch_test.dart';
import 'package:arch_test/src/testing/exception.dart';
import 'package:test/test.dart';

import '../../mock/models.dart';

void main() {
  late DartPackage package;
  late ArchTest<DartClass> allClassesHaveConstConstructorTest;
  late ArchTest<DartClass> allClassesHaveConstructorTest;

  setUp(() {
    allClassesHaveConstructorTest = ArchTest<DartClass>(
      filter: (pkg) => pkg.libraries
          .map((lib) => lib.classes)
          .fold(<DartClass>[], (cls1, cls2) => [...cls1, ...cls2]),
      condition: (cls, addViolation) {
        final hasConstructor =
            cls.methods.any((method) => method.kind == MethodKind.CONSTRUCTOR);
        if (!hasConstructor) {
          addViolation('All classes should have a constructor');
        }
      },
    );
    allClassesHaveConstConstructorTest = ArchTest<DartClass>(
      filter: (pkg) => pkg.libraries
          .map((lib) => lib.classes)
          .fold(<DartClass>[], (cls1, cls2) => [...cls1, ...cls2]),
      condition: (cls, addViolation) {
        final hasConstConstructor = cls.methods.any((method) =>
            method is DartConstructor &&
            method.constructorKind == ConstructorKind.CONST);
        if (!hasConstConstructor) {
          addViolation('All classes should have a const constructor');
        }
      },
    );
    package = createSamplePackage();
  });

  test('Should succeed on check that all classes have constructor', () {
    final violations = allClassesHaveConstructorTest.getViolations(package);

    expect(violations, []);
  });

  test('Should fail on check that all classes have const constructor', () {
    final violations =
        allClassesHaveConstConstructorTest.getViolations(package);

    expect(violations, ['All classes should have a const constructor']);
  });

  test('Should not throw exception for if no violations are found', () {
    allClassesHaveConstructorTest.validate(package);
    expect(allClassesHaveConstructorTest.getViolations(package), []);
  });

  test('Should throw ViolationsException', () {
    try {
      allClassesHaveConstConstructorTest.validate(package);
      fail("Should've thrown ViolationsException");
    } on ViolationsException catch (e) {
      expect(
          allClassesHaveConstConstructorTest.getViolations(package).length, 1);
      expect(e.violations, ['All classes should have a const constructor']);
      expect(e.package, package);
    }
  });
}
