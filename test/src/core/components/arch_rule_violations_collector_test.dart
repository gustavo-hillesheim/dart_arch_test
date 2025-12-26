import 'package:arch_test/arch_test.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late ArchRuleViolationsCollector collector;

  group('ArchRuleViolationsCollector', () {
    setUp(() {
      collector = ArchRuleViolationsCollector();
    });

    test('should collect error violaton', () {
      final element = FakeClassElement();

      collector.add(
        element,
        ViolationSeverity.error,
        'Error message',
      );

      expect(collector.allViolations, [
        ArchRuleViolation(
          element: element,
          message: 'Error message',
          severity: ViolationSeverity.error,
        )
      ]);
    });

    test('should collect warning violaton', () {
      final element = FakeClassElement();

      collector.add(
        element,
        ViolationSeverity.warning,
        'Error message',
      );

      expect(collector.allViolations, [
        ArchRuleViolation(
          element: element,
          message: 'Error message',
          severity: ViolationSeverity.warning,
        )
      ]);
    });
  });
}
