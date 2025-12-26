import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

abstract class ArchRule<E extends Element> implements ElementPredicate<E> {
  void check(E element, ReportViolation reportViolation);

  @override
  bool satisfies(E element) {
    bool hasViolation = false;
    check(element, (_, [__]) => hasViolation = true);
    return hasViolation;
  }
}

typedef ReportViolation = void Function(ViolationSeverity severity,
    [String? message]);
