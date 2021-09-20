import 'package:arch_test/arch_test.dart';

typedef Selector<T extends DartElement> = List<T> Function(
  DartPackage package,
);

typedef Validation<T extends DartElement> = void Function(
  T target,
  DartPackage package,
  void Function(String) addViolation,
);
