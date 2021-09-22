import 'package:arch_test/core/models/models.dart';

class Validation<T extends DartElement> {
  final ValidationFn<T> validation;

  Validation(this.validation);

  void call(T target, DartPackage package, void Function(String) addViolation) {
    return validation(target, package, addViolation);
  }
}

typedef ValidationFn<T extends DartElement> = void Function(
  T target,
  DartPackage package,
  void Function(String) addViolation,
);
