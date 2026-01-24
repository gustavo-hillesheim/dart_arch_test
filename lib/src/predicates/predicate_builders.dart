import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:arch_test/arch_test.dart';

ElementPredicate<E> have<E extends Element, P>(
  ElementPropertyAcessor<E, P> accessor,
  ValueMatcher<P> matcher,
) {
  return HaveElementPredicate(accessor, matcher);
}

ElementPredicate<E> be<E extends Element>(
    ElementPropertyAcessor<E, bool> accessor) {
  return BeElementPredicate(accessor);
}

ElementPropertyAcessor<E, String?> name<E extends Element>() {
  return FunctionalPropertyAccessor<E, String?>(
    description: 'name',
    getter: (element) => element.name,
  );
}

ElementPropertyAcessor<E, String?> libraryPath<E extends Element>() {
  return FunctionalPropertyAccessor<E, String?>(
    description: 'library path',
    getter: (element) => element.firstFragment.libraryFragment?.source.uri.path,
  );
}

ElementPropertyAcessor<E, bool> abstract<E extends ClassElement>() {
  return FunctionalPropertyAccessor<E, bool>(
    description: 'abstract',
    getter: (element) => element.isAbstract,
  );
}

ElementPropertyAcessor<E, bool> interface<E extends ClassElement>() {
  return FunctionalPropertyAccessor<E, bool>(
    description: 'interface',
    getter: (element) => element.isInterface,
  );
}

ElementPropertyAcessor<E, List<InterfaceType>>
    interfaces<E extends ClassElement>() {
  return FunctionalPropertyAccessor<E, List<InterfaceType>>(
    description: 'interfaces',
    getter: (element) => element.interfaces,
  );
}

ValueMatcher<String?> endingWith(String suffix) {
  return FunctionalValueMatcher<String?>(
    description: 'ending with "$suffix"',
    matcher: (value) => value != null && value.endsWith(suffix),
  );
}

ValueMatcher<String?> containing(String substring) {
  return FunctionalValueMatcher<String?>(
    description: 'containing "$substring"',
    matcher: (value) => value != null && value.contains(substring),
  );
}

class HaveElementPredicate<E extends Element, P> extends ElementPredicate<E> {
  final ElementPropertyAcessor<E, P> accessor;
  final ValueMatcher<P> matcher;

  HaveElementPredicate(this.accessor, this.matcher);

  @override
  String describe() {
    return 'have ${accessor.describe()} ${matcher.describe()}';
  }

  @override
  bool satisfies(E element) {
    final value = accessor.getValue(element);
    return matcher.matches(value);
  }
}

class BeElementPredicate<E extends Element> extends ElementPredicate<E> {
  final ElementPropertyAcessor<E, bool> accessor;

  BeElementPredicate(this.accessor);

  @override
  String describe() {
    return 'be ${accessor.describe()}';
  }

  @override
  bool satisfies(E element) {
    return accessor.getValue(element);
  }
}

abstract interface class ElementPropertyAcessor<E extends Element, P> {
  String describe();

  P getValue(E element);
}

class FunctionalPropertyAccessor<E extends Element, P>
    extends ElementPropertyAcessor<E, P> {
  final String description;
  final P Function(E element) getter;

  FunctionalPropertyAccessor({
    required this.description,
    required this.getter,
  });

  @override
  String describe() {
    return description;
  }

  @override
  P getValue(E element) {
    return getter(element);
  }
}

abstract interface class ValueMatcher<P> {
  String describe();

  bool matches(P value);
}

class FunctionalValueMatcher<P> extends ValueMatcher<P> {
  final String description;
  final bool Function(P value) matcher;

  FunctionalValueMatcher({
    required this.description,
    required this.matcher,
  });

  @override
  String describe() {
    return description;
  }

  @override
  bool matches(P value) {
    return matcher(value);
  }
}
