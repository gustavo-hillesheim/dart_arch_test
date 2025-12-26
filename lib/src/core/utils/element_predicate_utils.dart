import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

extension ElementPredicateExtension<E extends Element> on ElementPredicate<E> {
  ArchTest should(ElementPredicate<E> predicate) {
    final selector = this is ElementSelector
        ? this as ElementSelector
        : ElementPredicateToSelectorAdapter<E>(this);
    final rule = predicate is ArchRule?
        ? predicate as ArchRule
        : ElementPredicateToArchRuleAdapter<E>(predicate);

    return ArchTest(
      selector: selector,
      rule: rule,
    );
  }
}

class ElementPredicateToSelectorAdapter<E extends Element>
    extends ElementSelector<E, E> {
  final ElementPredicate<E> predicate;

  ElementPredicateToSelectorAdapter(this.predicate);

  @override
  String describe() {
    return predicate.describe();
  }

  @override
  List<E> select(List<E> elements) {
    return elements.where(predicate.satisfies).toList();
  }
}

class ElementPredicateToArchRuleAdapter<E extends Element> extends ArchRule<E> {
  final ElementPredicate<E> predicate;

  ElementPredicateToArchRuleAdapter(this.predicate);

  @override
  String describe() {
    return predicate.describe();
  }

  @override
  void check(E element, ReportViolation reportViolation) {
    if (!predicate.satisfies(element)) {
      reportViolation(ViolationSeverity.error);
    }
  }
}
