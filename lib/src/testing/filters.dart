import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/testing/types.dart';

abstract class Filters {
  static List<T> id<T extends DartElement>(List<T> els) => els;

  static Filter<T> pathMatches<T extends DartElement>(String str) {
    return _createFilter((el) => RegExp(str).hasMatch(el.library));
  }

  static Filter<T> nameStartsWith<T extends DartElement>(String str) {
    return _createFilter((el) => el.name.startsWith(str));
  }

  static Filter<T> nameEndsWith<T extends DartElement>(String str) {
    return _createFilter((el) => el.name.endsWith(str));
  }

  static Filter<T> _createFilter<T extends DartElement>(
      bool Function(T) matchFn) {
    return (List<T> elements) {
      return elements.where(matchFn).toList(growable: false);
    };
  }
}
