import 'package:analyzer/dart/element/element.dart';

import '../components/components.dart';

abstract class RuleChecker<E extends Element> {
  String describe();

  void check(E element, RuleViolationCollector collector);
}
