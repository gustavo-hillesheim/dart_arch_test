import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/components/dart_element_finder.dart';
import 'package:arch_test/src/testing/types.dart';

abstract class ElementsProviders {
  static final _finder = DartElementFinder();

  static ElementsProvider<DartLibrary> libraries =
      (package) => _finder.findByType<DartLibrary>(source: package);

  static ElementsProvider<DartClass> classes =
      (package) => _finder.findByMatcher(
            source: package,
            matcher: (el) => el is DartClass && !el.isEnum,
          );

  static ElementsProvider<DartClass> enums = (package) => _finder.findByMatcher(
        matcher: (el) => el is DartClass && el.isEnum,
        source: package,
      );

  static ElementsProvider<DartMethod> methods =
      (package) => _finder.findByType<DartMethod>(source: package);
}
