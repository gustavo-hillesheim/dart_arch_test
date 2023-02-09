import '../../core/models/models.dart';

class Selector<T extends DartElement> {
  final SelectorFn<T> selector;
  final String description;

  Selector(this.selector, {required this.description});

  List<T> call(DartPackage package) {
    return selector(package);
  }
}

typedef SelectorFn<T extends DartElement> = List<T> Function(
  DartPackage package,
);
