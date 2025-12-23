library;

import 'src/core/core.dart';

export 'src/assertions/assertions.dart';
export 'src/core/core.dart';
export 'src/matchers/matchers.dart';

void archTest(ArchRule rule) {
  ArchTestDeclarator.instance.addTestFor(rule);
}
