import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/core.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  group('ArchTestsRunner', () {
    test('SHOULD return empty list for test with no violations', () {
      final runner = ArchTestsRunner(
        tests: [
          classes
              .that(resideIn('entities'))
              .should(haveNameEndingWith('Entity')),
        ],
        packageLibraries: mockLibraries,
      );

      final violations = runner.runTests();

      expect(violations, isEmpty);
    });

    test('SHOULD return violation for test with violations', () {
      final test = classes
          .that(resideIn('service'))
          .should(haveNameEndingWith('Entity'));

      final runner = ArchTestsRunner(
        tests: [test],
        packageLibraries: mockLibraries,
      );

      final violations = runner.runTests();

      expect(violations, [
        ArchRuleViolation(
          element: productServiceMockClass,
          message: test.describe(),
          severity: ViolationSeverity.error,
        )
      ]);
    });
  });
}
