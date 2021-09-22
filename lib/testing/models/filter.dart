import 'package:arch_test/core/models/dart_element.dart';

class Filter<T extends DartElement> {
  final FilterFn<T> filter;

  Filter(this.filter);

  bool call(T element) {
    return filter(element);
  }

  Filter<T> and(Filter<T> filterToCombine) {
    return Filter((el) => filter(el) && filterToCombine(el));
  }
}

typedef FilterFn<T> = bool Function(T element);
