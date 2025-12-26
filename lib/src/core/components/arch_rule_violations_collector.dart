import 'package:analyzer/dart/element/element.dart';

import '../models/models.dart';

class ArchRuleViolationsCollector {
  final _violations = <ArchRuleViolation>[];

  List<ArchRuleViolation> get allViolations => List.unmodifiable(_violations);

  void add(Element element, ViolationSeverity severity, String message) {
    _violations.add(ArchRuleViolation(
      element: element,
      message: message,
      severity: severity,
    ));
  }
}
