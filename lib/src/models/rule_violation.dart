import 'package:analyzer/dart/element/element.dart';
import 'package:equatable/equatable.dart';

class RuleViolation<E extends Element> extends Equatable {
  const RuleViolation({
    required this.element,
    required this.message,
    required this.severity,
  });

  final E element;
  final String message;
  final ViolationSeverity severity;

  @override
  List<Object?> get props => [element, message, severity];
}

enum ViolationSeverity {
  warning,
  error,
}
