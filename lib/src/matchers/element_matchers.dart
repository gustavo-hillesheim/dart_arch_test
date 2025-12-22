import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

const classes = TypeElementMatcher<ClassElement>();

ResideInDirectoryMatcher<E> resideInDirectory<E extends Element>(
    String directory) {
  return ResideInDirectoryMatcher<E>(directory);
}

extension ElementMatcherExtension<E extends Element> on ElementMatcher<E> {
  ElementMatcher<E> that(ElementMatcher<E> filter) {
    return FilteringElementMatcher<E>(this, filter);
  }

  ArchRule should(RuleChecker<E> ruleChecker) {
    return ArchRule<E>(
      elementMatcher: this,
      checker: ruleChecker,
    );
  }
}

class TypeElementMatcher<E extends Element> extends ElementMatcher<E> {
  const TypeElementMatcher();

  @override
  bool matches(E item) {
    return true;
  }
}

class ResideInDirectoryMatcher<E extends Element> extends ElementMatcher<E> {
  final String directory;

  ResideInDirectoryMatcher(this.directory);

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
  bool matches(E item) {
    return source.matches(item) && filter.matches(item);
  }
}
