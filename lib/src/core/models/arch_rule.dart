import 'package:analyzer/dart/element/element.dart';

import '../components/components.dart';

abstract class ArchRule<E extends Element> {
  String describe();

  void check(E element, ArchRuleViolationsCollector collector);
}
