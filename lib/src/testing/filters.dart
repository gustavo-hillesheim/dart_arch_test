import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/testing/types.dart';

abstract class Filters {
  static bool id<T extends DartElement>(T el) => true;

  static Filter<T> pathMatches<T extends DartElement>(String regExp) {
    return (el) => RegExp(regExp).hasMatch(el.library);
  }

  static Filter<T> nameStartsWith<T extends DartElement>(String str) {
    return (el) => el.name.startsWith(str);
  }

  static Filter<T> nameEndsWith<T extends DartElement>(String str) {
    return (el) => el.name.endsWith(str);
  }

  static Filter<T> combine<T extends DartElement>(List<Filter<T>> filters) {
    return (el) {
      for (final filter in filters) {
        if (!filter(el)) {
          return false;
        }
      }
      return true;
    };
  }
}
