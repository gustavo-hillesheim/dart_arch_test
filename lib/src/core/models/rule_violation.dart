import 'package:analyzer/dart/element/element.dart';
import 'package:equatable/equatable.dart';

class ArchRuleViolation extends Equatable {
  const ArchRuleViolation({
    required this.element,
    required this.message,
    required this.severity,
  });

  final Element element;
  final String message;
  final ViolationSeverity severity;

  @override
  List<Object?> get props => [element, message, severity];
}

enum ViolationSeverity {
  warning,
  error,
}
