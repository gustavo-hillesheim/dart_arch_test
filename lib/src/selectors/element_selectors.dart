import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

const classes = TypeElementSelector<ClassElement>(description: 'classes');

ResideInDirectorySelector<E> resideInDirectory<E extends Element>(
    String directory) {
  return ResideInDirectorySelector<E>(directory);
}

extension ElementSelectorExtension<E extends Element, O extends Element>
    on ElementSelector<E, O> {
  ElementSelector<E, O2> that<O2 extends Element>(
      ElementSelector<O, O2> filter) {
    return FilteringElementSelector<E, O, O2>(this, filter);
  }

  ArchTest should(RuleAssertion<O> ruleChecker) {
    return ArchTest<O>(
      selector: this,
      assertion: ruleChecker,
    );
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

class ResideInDirectorySelector<E extends Element>
    extends ElementSelector<E, E> {
  final String directory;

  ResideInDirectorySelector(this.directory);

  @override
  String describe() {
    return 'reside in directory "$directory"';
  }

  @override
  List<E> select(List<E> elements) {
    return elements.where((element) {
      final fileUri = element.firstFragment.libraryFragment?.source.uri;
      return fileUri?.path.contains(directory) ?? false;
    }).toList();
  }
}

class FilteringElementSelector<E extends Element, O extends Element,
    O2 extends Element> extends ElementSelector<E, O2> {
  final ElementSelector<E, O> source;
  final ElementSelector<O, O2> filter;

  FilteringElementSelector(this.source, this.filter);

  @override
  String describe() {
    return '${source.describe()} that ${filter.describe()}';
  }

  @override
  List<O2> select(List<E> elements) {
    return filter.select(source.select(elements));
  }
}
