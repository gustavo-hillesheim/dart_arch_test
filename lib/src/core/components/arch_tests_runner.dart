import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

class ArchTestsRunner {
  const ArchTestsRunner({
    required this.tests,
    required this.packageLibraries,
  });

  final List<ArchTest> tests;
  final List<LibraryElement> packageLibraries;

  List<RuleViolation> runTests() {
    final violationsCollector = RuleViolationCollector();
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
    RuleViolationCollector violationsCollector,
  ) {
    final candidateElements =
        test.elementMatcher.findMatchingElementsIn(packageElements);
    for (final element in candidateElements) {
      test.assertion.check(element, violationsCollector);
    }
  }
}
