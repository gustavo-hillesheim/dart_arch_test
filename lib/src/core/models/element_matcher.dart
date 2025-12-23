import 'package:analyzer/dart/element/element.dart';

abstract class ElementMatcher<E extends Element> {
  const ElementMatcher();

  String describe();

  bool matches(E item);

  List<E> findMatchingElementsIn(List<Element> elements) {
    return elements.whereType<E>().where(matches).toList();
  }
}
