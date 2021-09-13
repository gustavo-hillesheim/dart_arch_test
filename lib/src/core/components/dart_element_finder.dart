import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_element_ref.dart';

class DartElementFinder {
  List<T> findByRef<T extends DartElement>(DartElementRef ref,
      {required DartElementsParent source}) {
    return findByMatcher(source: source, matcher: (el) => ref.matches(el));
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
