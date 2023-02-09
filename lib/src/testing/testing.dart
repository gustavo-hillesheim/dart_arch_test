import 'models/arch_rule.dart';
import '../core/components/dart_package_loader.dart';

import 'package:test/test.dart';

void archTest(ArchRule rule) {
  test(rule.description, () async {
    final package = await DartPackageLoader.instance.loadCurrentPackage();
    rule.validate(package);
  });
}
