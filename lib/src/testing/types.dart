import 'package:arch_test/arch_test.dart';

typedef ElementsProvider<T extends DartElement> = List<T> Function(
  DartPackage package,
);

typedef Filter<T extends DartElement> = bool Function(T element);

typedef Validation<T extends DartElement> = void Function(
  T target,
  DartPackage package,
  void Function(String) addViolation,
);
