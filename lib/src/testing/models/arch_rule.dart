import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/testing/exception.dart';
import 'package:arch_test/src/testing/premade/filters.dart';
import 'package:arch_test/src/testing/models/element_violations.dart';
import 'package:arch_test/src/testing/models/filter.dart';
import 'package:arch_test/src/testing/models/types.dart';

class ArchRule<T extends DartElement> {
  final Selector<T> selector;
  final Filter<T> filter;
  final Validation<T> validation;

  ArchRule({
    required this.selector,
    required this.validation,
    Filter<T>? filter,
  }) : filter = filter ?? Filters.id();

  void validate(DartPackage package) {
    final violations = getViolations(package);
    if (violations.isNotEmpty) {
      throw ViolationsException(violations: violations, package: package);
    }
  }

  List<ElementViolations> getViolations(DartPackage package) {
    final violations = <ElementViolations>[];
    final targets = selector(package).where(filter);
    for (final target in targets) {
      final elementViolations = ElementViolations(target);
      validation(target, package, elementViolations.add);
      if (elementViolations.isNotEmpty) {
        violations.add(elementViolations);
      }
    }
    return violations;
  }
}
