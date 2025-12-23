import 'package:analyzer/dart/element/element.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class ArchRule<E extends Element> extends Equatable {
  const ArchRule({
    required this.elementMatcher,
    required this.assertion,
  });

  final ElementMatcher<E> elementMatcher;
  final RuleAssertion<E> assertion;

  String describe() {
    return '${elementMatcher.describe()} should ${assertion.describe()}';
  }

  @override
  List<Object?> get props => [elementMatcher, assertion];
}
