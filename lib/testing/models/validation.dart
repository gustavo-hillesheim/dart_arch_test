import 'package:arch_test/core/models/models.dart';

class Validation<T extends DartElement> {
  final ValidationFn<T> validation;
  final String description;

  Validation(this.validation, {required this.description});

  void call(T target, DartPackage package, void Function(String) addViolation) {
    return validation(target, package, addViolation);
  }

  Validation<T> and(Validation<T> otherValidation) {
    return Validation(
      (target, package, addViolation) {
        validation(target, package, addViolation);
        otherValidation(target, package, addViolation);
      },
      description: '$description AND ${otherValidation.description}',
    );
  }
}

typedef ValidationFn<T extends DartElement> = void Function(
  T target,
  DartPackage package,
  void Function(String) addViolation,
);
