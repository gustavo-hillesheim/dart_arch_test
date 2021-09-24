export 'models/models.dart';
export 'premade/premade.dart';
export 'exception.dart';

import 'package:arch_test/arch_test.dart';
import 'package:test/test.dart';

void archTest(ArchRule rule) {
  test(rule.description, () async {
    final package = await DartPackageLoader.instance.loadCurrentPackage();
    rule.validate(package);
  });
}
