import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/testing/filters.dart';
import 'package:arch_test/src/testing/types.dart';
import '../exception.dart';

class ArchTest<T extends DartElement> {
  final ElementsProvider<T> elementsProvider;
  final Filter<T> filter;
  final Validation<T> validation;

  ArchTest({
    required this.elementsProvider,
    required this.validation,
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
      validation(target, violations.add);
    }
    return violations;
  }
}
