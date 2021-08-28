import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_library_factory.dart';
import 'package:arch_test/src/core/models/dart_library.dart';
import 'package:arch_test/src/core/models/dart_package.dart';

class DartPackageLoader {
  final MirrorSystem mirrorSystem;
  final DartLibraryFactory dartLibraryFactory;

  DartPackageLoader(this.mirrorSystem, this.dartLibraryFactory);

  DartPackage loadPackage(String packageName) {
    final libraries = _findLibraries(packageName);
    return DartPackage(name: packageName, libraries: libraries);
  }

  List<DartLibrary> _findLibraries(String packageName) {
    return _findLibrariesOfPackage(packageName)
        .map(dartLibraryFactory.fromLibraryMirror)
        .toList(growable: false);
  }

  List<LibraryMirror> _findLibrariesOfPackage(String packageName) {
    return mirrorSystem.libraries.values
        .where((lib) => lib.uri.toString().startsWith('package:$packageName'))
        .toList(growable: false);
  }
}
