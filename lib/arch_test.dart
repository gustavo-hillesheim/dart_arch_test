library;

import 'src/models/models.dart';
import 'src/components/components.dart';

export 'src/components/components.dart';
export 'src/matchers/matchers.dart';
export 'src/models/models.dart';
export 'src/rule_assertions/rule_assertions.dart';

void archTest(ArchRule rule) {
  ArchTestDeclarator.instance.addTestFor(rule);
}
