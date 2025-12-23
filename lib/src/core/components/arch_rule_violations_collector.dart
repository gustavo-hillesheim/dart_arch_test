import 'package:analyzer/dart/element/element.dart';

import '../models/models.dart';

class ArchRuleViolationsCollector {
  final _violations = <ArchRuleViolation>[];

  List<ArchRuleViolation> get allViolations => List.unmodifiable(_violations);

  void warn<E extends Element>(E element, String message) {
    _violations.add(ArchRuleViolation(
      element: element,
      message: message,
      severity: ViolationSeverity.warning,
    ));
  }

  void error<E extends Element>(E element, String message) {
    _violations.add(ArchRuleViolation(
      element: element,
      message: message,
      severity: ViolationSeverity.error,
    ));
  }
}
