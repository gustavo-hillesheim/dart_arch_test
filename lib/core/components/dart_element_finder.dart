import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/dart_element_ref.dart';
import 'package:arch_test/core/exception.dart';

class DartElementFinder {
  static DartElementFinder? _instance;
  static DartElementFinder get instance {
    _instance ??= DartElementFinder();
    return _instance!;
  }

  T? findByRef<T extends DartElement>(
    DartElementRef<T> ref, {
    required DartElementsParent source,
  }) {
    return findOneByMatcher<T>(
        source: source, matcher: (el) => ref.matches(el));
  }

  List<T> findByType<T extends DartElement>({
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
      throw MultipleElementsFoundException(
        matcher: matcher,
        source: source,
        elementsFound: elementsFound,
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