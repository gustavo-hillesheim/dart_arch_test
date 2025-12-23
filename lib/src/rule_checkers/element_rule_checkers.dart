import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

HaveNameEndingWithRuleChecker<E> haveNameEndingWith<E extends Element>(
    String suffix) {
  return HaveNameEndingWithRuleChecker<E>(suffix);
}

class HaveNameEndingWithRuleChecker<E extends Element> extends RuleChecker<E> {
  final String suffix;

  HaveNameEndingWithRuleChecker(this.suffix);

  @override
  String describe() {
    return 'have name ending with "$suffix"';
  }

  @override
  void check(Element element, RuleViolationCollector violationCollector) {
    final name = element.name;
    if (name == null || !name.endsWith(suffix)) {
      violationCollector.error(
        element,
        '$E "$name" does not have name ending with "$suffix".',
      );
    }
  }
}
