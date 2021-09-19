import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/testing/models/element_violations.dart';

class ViolationsException implements Exception {
  final List<ElementViolations> violations;
  final DartPackage package;

  ViolationsException({required this.violations, required this.package});

  String describeViolations() {
    final header =
        'Found the following violations in package ${package.name}:\n';
    final body = violations.map(_createDescription).join('\n\n');
    return '$header\n$body';
  }

  String _createDescription(ElementViolations violations) {
    final location = violations.element.location;
    final header =
        'Violations of ${violations.element.name} (located at ${location.uri}:${location.line}:${location.column}):';
    final body = violations.violations.map((v) => '- $v').join('\n');
    return '$header\n$body';
  }

  @override
  String toString() {
    return describeViolations();
  }
}
