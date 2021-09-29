import 'dart:io';
import 'dart:mirrors';

import 'package:arch_test/core/core.dart';
import 'package:arch_test/src/utils.dart';

class DartPackageLoader {
  static late DartPackageLoader instance = DartPackageLoader(
    currentMirrorSystem(),
    LibraryMirrorMapper.instance,
  );

  final MirrorSystem mirrorSystem;
  final LibraryMirrorMapper libraryMirrorMapper;

  DartPackageLoader(this.mirrorSystem, this.libraryMirrorMapper);

  Future<DartPackage> loadCurrentPackage() async {
    final packageName = await findNearestPackageName(Directory.current);
    return loadPackage(packageName);
  }

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
