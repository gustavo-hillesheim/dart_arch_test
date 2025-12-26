import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

abstract class ElementSelector<E extends Element, O extends Element>
    implements ElementPredicate<E> {
  const ElementSelector();

  List<O> select(List<E> elements);

  @override
  bool satisfies(E element) {
    final selected = select([element]);
    return selected.length == 1 && selected.first == element;
  }
}
