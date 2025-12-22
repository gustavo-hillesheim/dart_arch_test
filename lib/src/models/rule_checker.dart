import 'package:analyzer/dart/element/element.dart';

import '../components/components.dart';

abstract class RuleChecker<E extends Element> {
  void check(E element, RuleViolationCollector collector);
}
