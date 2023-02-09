import '../../core/models/dart_element.dart';

class Filter<T extends DartElement> {
  final FilterFn<T> filter;
  final String description;

  Filter(this.filter, {required this.description});

  bool call(T element) {
    return filter(element);
  }

  Filter<T> and(Filter<T> otherFilter) {
    return Filter(
      (el) => filter(el) && otherFilter(el),
      description: '$description AND ${otherFilter.description}',
    );
  }

  Filter<T> or(Filter<T> otherFilter) {
    return Filter(
      (el) => filter(el) || otherFilter(el),
      description: '$description OR ${otherFilter.description}',
    );
  }
}

typedef FilterFn<T> = bool Function(T element);
