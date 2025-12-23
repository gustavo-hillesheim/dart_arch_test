import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

const classes = TypeElementMatcher<ClassElement>(description: 'classes');

ResideInDirectoryMatcher<E> resideInDirectory<E extends Element>(
    String directory) {
  return ResideInDirectoryMatcher<E>(directory);
}

extension ElementMatcherExtension<E extends Element> on ElementMatcher<E> {
  ElementMatcher<E> that(ElementMatcher<E> filter) {
    return FilteringElementMatcher<E>(this, filter);
  }

  ArchTest should(RuleAssertion<E> ruleChecker) {
    return ArchTest<E>(
      elementMatcher: this,
      assertion: ruleChecker,
    );
  }
}

class TypeElementMatcher<E extends Element> extends ElementMatcher<E> {
  const TypeElementMatcher({this.description});

  final String? description;

  @override
  String describe() {
    return description ?? 'Elements of type $E';
  }

  @override
  bool matches(E item) {
    return true;
  }
}

class ResideInDirectoryMatcher<E extends Element> extends ElementMatcher<E> {
  final String directory;

  ResideInDirectoryMatcher(this.directory);

  @override
  String describe() {
    return 'reside in directory "$directory"';
  }

  @override
  bool matches(E item) {
    final fileUri = item.firstFragment.libraryFragment?.source.uri;
    return fileUri?.path.contains(directory) ?? false;
  }
}

class FilteringElementMatcher<E extends Element> extends ElementMatcher<E> {
  final ElementMatcher<E> source;
  final ElementMatcher<E> filter;

  FilteringElementMatcher(this.source, this.filter);

  @override
  String describe() {
    return '${source.describe()} that ${filter.describe()}';
  }

  @override
  bool matches(E item) {
    return source.matches(item) && filter.matches(item);
  }
}
