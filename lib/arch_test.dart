library;

import 'src/models/models.dart';
import 'src/components/components.dart';

export 'src/components/components.dart';
export 'src/matchers/matchers.dart';
export 'src/models/models.dart';
export 'src/rule_checkers/rule_checkers.dart';

void archTest(ArchRule rule) {
  ArchTestDeclarator.instance.addTestFor(rule);
}
