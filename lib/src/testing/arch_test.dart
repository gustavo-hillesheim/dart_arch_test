import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/testing/filters.dart';
import 'package:arch_test/src/testing/types.dart';
import '../exception.dart';

class ArchTest<T extends DartElement> {
  final ElementsProvider<T> elementsProvider;
  final Filter<T> filter;
  final Condition<T> condition;

  ArchTest({
    required this.elementsProvider,
    required this.condition,
    Filter<T>? filter,
  }) : filter = filter ?? Filters.id;

  void validate(DartPackage package) {
    final violations = getViolations(package);
    if (violations.isNotEmpty) {
      throw ViolationsException(violations: violations, package: package);
    }
  }

  List<String> getViolations(DartPackage package) {
    final violations = <String>[];
    final targets = filter(elementsProvider(package));
    for (final target in targets) {
      condition(target, violations.add);
    }
    return violations;
  }
}
