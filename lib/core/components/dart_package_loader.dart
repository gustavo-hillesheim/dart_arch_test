import 'dart:mirrors';

import 'package:arch_test/core/core.dart';

class DartPackageLoader {
  static DartPackageLoader? _instance;
  static DartPackageLoader get instance {
    _instance ??= DartPackageLoader(
      currentMirrorSystem(),
      LibraryMirrorMapper.instance,
    );
    return _instance!;
  }

  final MirrorSystem mirrorSystem;
  final LibraryMirrorMapper libraryMirrorMapper;

  DartPackageLoader(this.mirrorSystem, this.libraryMirrorMapper);

  DartPackage loadPackage(String packageName) {
    final libraries = _findLibraries(packageName);
    return DartPackage(name: packageName, libraries: libraries);
  }

  List<DartLibrary> _findLibraries(String packageName) {
    return _findLibrariesOfPackage(packageName)
        .map(libraryMirrorMapper.toDartLibrary)
        .toList(growable: false);
  }

  List<LibraryMirror> _findLibrariesOfPackage(String packageName) {
    return mirrorSystem.libraries.values
        .where((lib) => lib.uri.toString().startsWith('package:$packageName'))
        .toList(growable: false);
  }
}
