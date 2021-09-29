import '../exception.dart';
import '../premade/filters.dart';
import 'models.dart';
import '../../core/models/models.dart';

class ArchRule<T extends DartElement> {
  final Selector<T> selector;
  final Filter<T> filter;
  final Validation<T> validation;

  ArchRule({
    required this.selector,
    required this.validation,
    Filter<T>? filter,
  }) : filter = filter ?? Filters.id();

  String get description {
    final selectorDescription = _formatDescription(
      selector.description,
      fallback: 'elements',
    );
    final filterDescription = _formatDescription(
      filter.description,
      fallback: 'exist',
    );
    final validationDescription = _formatDescription(
      validation.description,
      fallback: 'exist',
    );
    return '$selectorDescription THAT $filterDescription SHOULD $validationDescription';
  }

  String _formatDescription(String description, {required String fallback}) {
    if (description.trim().isEmpty) {
      return fallback;
    }
    return description.trim();
  }

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
