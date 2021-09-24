import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/components/dart_element_finder.dart';
import 'package:arch_test/testing/models/models.dart';

abstract class Selectors {
  static final _finder = DartElementFinder();

  static Selector<DartLibrary> libraries = Selector(
    (package) => _finder.findByType<DartLibrary>(source: package),
    description: 'libraries',
  );

  static Selector<DartClass> classes = Selector(
    (package) => _finder.findByMatcher(
      source: package,
      matcher: (el) => el is DartClass && !el.isEnum,
    ),
    description: 'classes',
  );

  static Selector<DartClass> enums = Selector(
    (package) => _finder.findByMatcher(
      matcher: (el) => el is DartClass && el.isEnum,
      source: package,
    ),
    description: 'enums',
  );

  static Selector<DartMethod> methods = Selector(
    (package) => _finder.findByType<DartMethod>(source: package),
    description: 'methods',
  );
}
