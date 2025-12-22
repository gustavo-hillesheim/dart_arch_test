library;

import 'src/models/models.dart';
import 'src/components/components.dart';

export 'src/models/models.dart';
export 'src/components/components.dart';

void archTest(ArchRule rule) {
  ArchTestDeclarator.instance.addTestFor(rule);
}
