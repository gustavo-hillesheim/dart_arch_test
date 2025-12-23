import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

class ArchTestsRunner {
  const ArchTestsRunner({
    required this.tests,
    required this.packageLibraries,
  });

  final List<ArchTest> tests;
  final List<LibraryElement> packageLibraries;

  List<ArchRuleViolation> runTests() {
    final violationsCollector = ArchRuleViolationsCollector();
    final allLibrariesAndTopLevelElements = packageLibraries
        .expand((library) => [
              library,
              ...library.children,
            ])
        .toList();
    for (final test in tests) {
      _runTest(
        test,
        allLibrariesAndTopLevelElements,
        violationsCollector,
      );
    }
    return violationsCollector.allViolations;
  }

  void _runTest(
    ArchTest test,
    List<Element> packageElements,
    ArchRuleViolationsCollector violationsCollector,
  ) {
    final elements = test.selector.select(packageElements);
    for (final element in elements) {
      test.rule.check(element, violationsCollector);
    }
  }
}
