import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

HaveNameEndingWithArchRule<E> haveNameEndingWith<E extends Element>(
  String suffix,
) {
  return HaveNameEndingWithArchRule<E>(suffix);
}

class HaveNameEndingWithArchRule<E extends Element> extends ArchRule<E> {
  final String suffix;

  HaveNameEndingWithArchRule(this.suffix);

  @override
  String describe() {
    return 'have name ending with "$suffix"';
  }

  @override
  void check(Element element, ArchRuleViolationsCollector violationCollector) {
    final name = element.name;
    if (name == null || !name.endsWith(suffix)) {
      violationCollector.error(
        element,
        '$E "$name" does not have name ending with "$suffix".',
      );
    }
  }
}
