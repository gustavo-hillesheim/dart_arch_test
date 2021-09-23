import 'package:arch_test/core/models/models.dart';

class Validation<T extends DartElement> {
  final ValidationFn<T> validation;
  final String description;

  Validation(this.validation, {required this.description});

  void call(T target, DartPackage package, void Function(String) addViolation) {
    return validation(target, package, addViolation);
  }
}

typedef ValidationFn<T extends DartElement> = void Function(
  T target,
  DartPackage package,
  void Function(String) addViolation,
);
