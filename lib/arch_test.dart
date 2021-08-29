import 'dart:mirrors';

import 'package:arch_test/src/core/dart_package_loader.dart';
import 'package:arch_test/src/core/factories/dart_library_factory.dart';
import 'package:arch_test/src/core/models/dart_package.dart';
import 'package:arch_test/src/di_container.dart';

export 'src/core/models/models.dart';

final diContainer = setupDIContainer();

class ArchTest {
  DartPackage loadPackage(String packageName) {
    final packageLoader = DartPackageLoader(
      currentMirrorSystem(),
      diContainer.resolve<DartLibraryFactory>(),
    );
    return packageLoader.loadPackage(packageName);
  }
}
