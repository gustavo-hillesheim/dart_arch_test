import 'package:analyzer/dart/element/element.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class ArchTest<E extends Element> extends Equatable {
  const ArchTest({
    required this.selector,
    required this.rule,
  });

  final ElementSelector<Element, E> selector;
  final ArchRule<E> rule;

  String describe() {
    return '${selector.describe()} should ${rule.describe()}';
  }

  @override
  List<Object?> get props => [selector, rule];
}
