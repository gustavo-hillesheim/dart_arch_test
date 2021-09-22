import 'package:arch_test/arch_test.dart';

class Selector<T extends DartElement> {
  final SelectorFn<T> selector;

  Selector(this.selector);

  List<T> call(DartPackage package) {
    return selector(package);
  }
}

typedef SelectorFn<T extends DartElement> = List<T> Function(
  DartPackage package,
);
