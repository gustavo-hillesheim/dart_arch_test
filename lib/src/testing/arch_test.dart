import 'package:arch_test/src/core/core.dart';
import 'exception.dart';

class ArchTest<T> {
  final TargetProvider<List<T>> targetProvider;
  final Condition<T> condition;

  ArchTest({
    required this.targetProvider,
    required this.condition,
  });

  void validate(DartPackage package) {
    final violations = getViolations(package);
    if (violations.isNotEmpty) {
      throw ViolationsException(violations: violations, package: package);
    }
  }

  List<String> getViolations(DartPackage package) {
    final violations = <String>[];
    final targets = targetProvider(package);
    for (final target in targets) {
      condition(target, violations.add);
    }
    return violations;
  }
}

typedef TargetProvider<T> = T Function(DartPackage package);
typedef Condition<T> = void Function(
    T target, void Function(String) addViolation);
