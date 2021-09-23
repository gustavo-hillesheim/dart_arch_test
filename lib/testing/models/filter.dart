import 'package:arch_test/core/models/dart_element.dart';

class Filter<T extends DartElement> {
  final FilterFn<T> filter;
  final String description;

  Filter(this.filter, {required this.description});

  bool call(T element) {
    return filter(element);
  }

  Filter<T> and(Filter<T> filterToCombine) {
    return Filter(
      (el) => filter(el) && filterToCombine(el),
      description: '$description AND ${filterToCombine.description}',
    );
  }
}

typedef FilterFn<T> = bool Function(T element);
