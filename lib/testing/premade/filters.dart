import 'package:arch_test/arch_test.dart';
import 'package:arch_test/testing/models/filter.dart';

abstract class Filters {
  static Filter<T> id<T extends DartElement>() {
    return Filter((_) => true, description: 'exist');
  }

  static Filter<T> pathMatches<T extends DartElement>(String regExp) {
    return Filter(
      (el) => RegExp(regExp).hasMatch(el.library),
      description: 'have path matching "$regExp"',
    );
  }

  static Filter<T> nameStartsWith<T extends DartElement>(String str) {
    return Filter(
      (el) => el.name.startsWith(str),
      description: 'have name starting with "$str"',
    );
  }

  static Filter<T> nameEndsWith<T extends DartElement>(String str) {
    return Filter(
      (el) => el.name.endsWith(str),
      description: 'have name ending with "$str"',
    );
  }
}
