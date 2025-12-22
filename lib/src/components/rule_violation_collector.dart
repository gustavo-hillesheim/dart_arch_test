import 'package:analyzer/dart/element/element.dart';

import '../models/models.dart';

class RuleViolationCollector {
  final _violations = <RuleViolation>[];

  void warn<E extends Element>(E element, String message) {
    _violations.add(RuleViolation(
      element: element,
      message: message,
      severity: ViolationSeverity.warning,
    ));
  }

  void error<E extends Element>(E element, String message) {
    _violations.add(RuleViolation(
      element: element,
      message: message,
      severity: ViolationSeverity.error,
    ));
  }
}
