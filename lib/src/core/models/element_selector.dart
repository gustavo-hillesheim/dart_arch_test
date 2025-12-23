import 'package:analyzer/dart/element/element.dart';

abstract class ElementSelector<E extends Element, O extends Element> {
  const ElementSelector();

  String describe();

  List<O> select(List<E> elements);
}
