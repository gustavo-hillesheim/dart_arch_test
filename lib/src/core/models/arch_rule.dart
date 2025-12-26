import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

abstract class ArchRule<E extends Element> implements ElementPredicate<E> {
  void check(E element, ArchRuleViolationsCollector collector);

  @override
  bool satisfies(E element) {
    final collector = ArchRuleViolationsCollector();
    check(element, collector);
    return collector.allViolations.isEmpty;
  }
}
