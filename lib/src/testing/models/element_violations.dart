import 'package:equatable/equatable.dart';
import '../../core/models/models.dart';

class ElementViolations<T extends DartElement> extends Equatable {
  final T element;
  final List<String> _violations;

  ElementViolations(this.element) : _violations = [];

  void add(String violation) {
    _violations.add(violation);
  }

  List<String> get violations => _violations.toList(growable: false);

  bool get isNotEmpty => _violations.isNotEmpty;

  @override
  List<Object?> get props => [element, _violations];
}
