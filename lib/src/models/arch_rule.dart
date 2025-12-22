import 'package:analyzer/dart/element/element.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class ArchRule<E extends Element> extends Equatable {
  const ArchRule({
    required this.elementMatcher,
    required this.checker,
  });

  final ElementMatcher<E> elementMatcher;
  final RuleChecker<E> checker;

  @override
  List<Object?> get props => [elementMatcher, checker];
}
