import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/testing/types.dart';

abstract class Filters {
  static Filter<List<DartLibrary>> libraries = (package) => package.libraries;

  static Filter<List<DartClass>> classes = (package) =>
      _reduce<DartClass>(package.libraries.map((lib) => lib.classes))
          .toList(growable: false);

  static Filter<List<DartMethod>> methods = (package) {
    final libraryMethods = _reduce(package.libraries.map((lib) => lib.methods));
    final classMethods = _reduce(package.libraries.map((lib) {
      final classesMethods = lib.classes.map((cls) => cls.methods);
      return _reduce(classesMethods);
    }));
    return libraryMethods + classMethods;
  };

  static List<T> _reduce<T>(Iterable<Iterable<T>> listOfLists) {
    return listOfLists.fold([], (l1, l2) => [...l1, ...l2]);
  }
}
