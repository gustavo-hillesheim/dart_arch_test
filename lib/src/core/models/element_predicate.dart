import 'package:analyzer/dart/element/element.dart';

abstract class ElementPredicate<E extends Element> {
  String describe();

  bool satisfies(E element);
}
