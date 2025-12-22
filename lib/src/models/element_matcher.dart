import 'package:analyzer/dart/element/element.dart';

import 'matcher.dart';

abstract class ElementMatcher<E extends Element> extends Matcher<E> {
  const ElementMatcher();

  List<E> findMatchingElementsIn(List<Element> elements) {
    return elements.whereType<E>().where(matches).toList();
  }
}
