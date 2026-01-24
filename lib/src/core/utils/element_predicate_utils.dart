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

  ElementPredicate<F> or<F extends Element>(ElementPredicate<F> other) {
    return OrElementPredicate<F>(
      first: cast(),
      second: other,
    );
  }

  ElementPredicate<F> and<F extends Element>(ElementPredicate<F> other) {
    return AndElementPredicate<F>(
      first: cast(),
      second: other,
    );
  }

  ElementPredicate<F> cast<F extends Element>() {
    return CastingElementPredicate<F>(this);
  }
}

class OrElementPredicate<E extends Element> extends ElementPredicate<E> {
  final ElementPredicate<E> first;
  final ElementPredicate<E> second;

  OrElementPredicate({required this.first, required this.second});

  @override
  String describe() {
    return '${first.describe()} or ${second.describe()}';
  }

  @override
  bool satisfies(E element) {
    return first.satisfies(element) || second.satisfies(element);
  }
}

class AndElementPredicate<E extends Element> extends ElementPredicate<E> {
  final ElementPredicate<E> first;
  final ElementPredicate<E> second;

  AndElementPredicate({required this.first, required this.second});

  @override
  String describe() {
    return '${first.describe()} and ${second.describe()}';
  }

  @override
  bool satisfies(E element) {
    return first.satisfies(element) && second.satisfies(element);
  }
}

class CastingElementPredicate<E extends Element> extends ElementPredicate<E> {
  final ElementPredicate predicate;

  CastingElementPredicate(this.predicate);

  @override
  String describe() {
    return predicate.describe();
  }

  @override
  bool satisfies(E element) {
    return predicate.satisfies(element);
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
