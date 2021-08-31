import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/factories/dart_library_factory.dart';
import 'package:arch_test/src/di_container.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../mock/mirror_system.dart';

void main() {
  late MirrorSystem mirrorSystem;
  late DartPackageLoader dartPackageLoader;

  setUp(() {
    final diContainer = setupDIContainer();
    mirrorSystem = FakeMirrorSystem();
    dartPackageLoader = DartPackageLoader(
        mirrorSystem, diContainer.resolve<DartLibraryFactory>());
  });

  test('should create DartPackage for given package', () {
    when(() => mirrorSystem.libraries).thenReturn(mockLibraries);

    final dartPackage = dartPackageLoader.loadPackage('fake_package');

    expect(dartPackage, isNot(null));
    expect(dartPackage.name, 'fake_package');
    expect(dartPackage.libraries.map((lib) => lib.name).toList(), [
      'fake_package.dart',
      'component1.dart',
      'component2.dart',
      'services\\service1.dart',
      'services\\service2.dart',
    ]);
  });
}
