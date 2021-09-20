import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/components/dart_element_finder.dart';
import 'package:arch_test/src/testing/models/types.dart';

abstract class Selectors {
  static final _finder = DartElementFinder();

  static Selector<DartLibrary> libraries =
      (package) => _finder.findByType<DartLibrary>(source: package);

  static Selector<DartClass> classes = (package) => _finder.findByMatcher(
        source: package,
        matcher: (el) => el is DartClass && !el.isEnum,
      );

  static Selector<DartClass> enums = (package) => _finder.findByMatcher(
        matcher: (el) => el is DartClass && el.isEnum,
        source: package,
      );

  static Selector<DartMethod> methods =
      (package) => _finder.findByType<DartMethod>(source: package);
}
