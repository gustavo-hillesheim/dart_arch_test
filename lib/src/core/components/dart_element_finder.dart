import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_element_ref.dart';

class DartElementFinder {
  T? findByRef<T extends DartElement>(
    DartElementRef ref, {
    required DartElementsParent source,
  }) {
    return findOneByMatcher<T>(
        source: source, matcher: (el) => ref.matches(el));
  }

  /// [type] Must be a type that extends DartElement, otherwise will return am empty list.
  List<T> findByType<T extends DartElement>({
    required Type type,
    required DartElementsParent source,
  }) {
    return findByMatcher(matcher: (el) => el is T, source: source);
  }

  T? findOneByMatcher<T extends DartElement>({
    required DartElementMatcher matcher,
    required DartElementsParent source,
  }) {
    final elementsFound = findByMatcher<T>(matcher: matcher, source: source);
    if (elementsFound.length == 1) {
      return elementsFound.first;
    } else if (elementsFound.isEmpty) {
      return null;
    } else {
      throw Exception(
        'Found more than one element on source $source with matcher $matcher.'
        'Total elements found: ${elementsFound.length}',
      );
    }
  }

  List<T> findByMatcher<T extends DartElement>({
    required DartElementMatcher matcher,
    required DartElementsParent source,
  }) {
    final elementsFound = <T>[];
    for (final el in source.children) {
      if (matcher(el)) {
        elementsFound.add(el as T);
      }
      if (el is DartElementsParent) {
        elementsFound.addAll(
          findByMatcher(matcher: matcher, source: el as DartElementsParent),
        );
      }
    }
    return elementsFound;
  }
}

typedef DartElementMatcher = bool Function(DartElement el);
