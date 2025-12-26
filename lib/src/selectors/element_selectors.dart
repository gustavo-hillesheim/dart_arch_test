import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

const classes = TypeElementSelector<ClassElement>(description: 'classes');

extension ElementSelectorExtension<E extends Element, O extends Element>
    on ElementSelector<E, O> {
  ElementSelector<E, O> that(ElementPredicate<O> filter) {
    return FilteringElementSelector<E, O>(this, filter);
  }
}

class TypeElementSelector<E extends Element>
    extends ElementSelector<Element, E> {
  const TypeElementSelector({this.description});

  final String? description;

  @override
  String describe() {
    return description ?? 'Elements of type $E';
  }

  @override
  List<E> select(List<Element> elements) {
    return elements.whereType<E>().toList();
  }
}

class FilteringElementSelector<E extends Element, O extends Element>
    extends ElementSelector<E, O> {
  final ElementSelector<E, O> source;
  final ElementPredicate<O> filter;

  FilteringElementSelector(this.source, this.filter);

  @override
  String describe() {
    return '${source.describe()} that ${filter.describe()}';
  }

  @override
  List<O> select(List<E> elements) {
    return source.select(elements).where(filter.satisfies).toList();
  }
}
