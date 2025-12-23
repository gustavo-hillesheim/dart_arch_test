import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

class ArchTestsRunner {
  const ArchTestsRunner({
    required this.declaredRules,
    required this.packageLibraries,
  });

  final List<ArchRule> declaredRules;
  final List<LibraryElement> packageLibraries;

  List<RuleViolation> checkRules() {
    final violationsCollector = RuleViolationCollector();
    final allLibrariesAndTopLevelElements = packageLibraries
        .expand((library) => [
              library,
              ...library.children,
            ])
        .toList();
    for (final rule in declaredRules) {
      _checkRule(
        rule,
        allLibrariesAndTopLevelElements,
        violationsCollector,
      );
    }
    return violationsCollector.allViolations;
  }

  void _checkRule(
    ArchRule rule,
    List<Element> packageElements,
    RuleViolationCollector violationsCollector,
  ) {
    final candidateElements =
        rule.elementMatcher.findMatchingElementsIn(packageElements);
    for (final element in candidateElements) {
      rule.checker.check(element, violationsCollector);
    }
  }
}
