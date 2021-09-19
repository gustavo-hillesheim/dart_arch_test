library arch_test;

import 'dart:mirrors';
import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/di_container.dart';

export 'src/core/components/components.dart';
export 'src/core/models/models.dart';
export 'src/core/exception.dart';
export 'src/testing/testing.dart';

final diContainer = setupDIContainer();

DartPackageLoader createPackageLoader() {
  return DartPackageLoader(
    currentMirrorSystem(),
    diContainer.resolve<LibraryMirrorMapper>(),
  );
}
