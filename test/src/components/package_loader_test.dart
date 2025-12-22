import 'dart:io';

import 'package:arch_test/arch_test.dart';
import 'package:test/test.dart';

void main() {
  group('PackageLoader', () {
    test('SHOULD load example package libraries', () async {
      final packageLoader = PackageLoader();
      final exampleDir = Directory('example');

      final libraries = await packageLoader.loadLibraries(exampleDir);

      expect(libraries, isNotEmpty);
      final libraryNames = libraries.map((lib) => lib.identifier).toList();
      expect(
          libraryNames,
          containsAll([
            'package:example/src/domain/entities/user_entity.dart',
          ]));
    });
  });
}
