import 'package:analyzer/dart/element/element.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class ArchTest<E extends Element> extends Equatable {
  const ArchTest({
    required this.selector,
    required this.assertion,
  });

  final ElementSelector<Element, E> selector;
  final RuleAssertion<E> assertion;

  String describe() {
    return '${selector.describe()} should ${assertion.describe()}';
  }

  @override
  List<Object?> get props => [selector, assertion];
}
