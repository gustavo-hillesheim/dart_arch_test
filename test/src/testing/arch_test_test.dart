import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/components/dart_element_finder.dart';
import 'package:arch_test/src/testing/arch_test.dart';
import 'package:arch_test/src/testing/exception.dart';
import 'package:arch_test/src/testing/models/element_violations.dart';
import 'package:test/test.dart';

import '../../mock/models.dart';

void main() {
  late DartPackage package;
  late ArchTest<DartClass> allClassesHaveConstConstructorTest;
  late ArchTest<DartClass> allClassesHaveConstructorTest;

  setUp(() {
    allClassesHaveConstructorTest = ArchTest<DartClass>(
      selector: (pkg) => DartElementFinder().findByMatcher(
        source: pkg,
        matcher: (el) => el is DartClass && !el.isEnum,
      ),
      filter: (_) => true,
      validation: (cls, _, addViolation) {
        final hasConstructor =
            cls.methods.any((method) => method.kind == MethodKind.CONSTRUCTOR);
        if (!hasConstructor) {
          addViolation('Should have a constructor');
        }
      },
    );
    allClassesHaveConstConstructorTest = ArchTest<DartClass>(
      selector: (pkg) => DartElementFinder().findByMatcher(
        source: pkg,
        matcher: (el) => el is DartClass && !el.isEnum,
      ),
      filter: (_) => true,
      validation: (cls, _, addViolation) {
        final hasConstConstructor = cls.methods.any((method) =>
            method is DartConstructor &&
            method.constructorKind == ConstructorKind.CONST);
        if (!hasConstConstructor) {
          addViolation('Should have a const constructor');
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

    expect(violations, [
      ElementViolations(createTestClass())
        ..add('Should have a const constructor'),
    ]);
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
      expect(e.violations, [
        ElementViolations(createTestClass())
          ..add('Should have a const constructor'),
      ]);
      expect(e.package, package);
    }
  });
}
