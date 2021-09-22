export 'models/models.dart';
export 'premade/premade.dart';
export 'exception.dart';

import 'package:arch_test/arch_test.dart';
import 'package:test/test.dart';

void archTest(String description, String packageName, ArchRule rule) {
  test(description, () {
    final package = DartPackageLoader.instance.loadPackage(packageName);
    rule.validate(package);
  });
}
