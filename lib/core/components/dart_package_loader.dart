import 'dart:io';
import 'dart:mirrors';

import 'package:arch_test/core/core.dart';
import 'package:yaml/yaml.dart';

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

  Future<DartPackage> loadCurrentPackage() async {
    final packageName = await _findNearestPackageName(Directory.current);
    return loadPackage(packageName);
  }

  Future<String> _findNearestPackageName(Directory directory) async {
    final pubspecPath = await _findNearestPubspecPath(directory);
    final pubspec = await File(pubspecPath).readAsString();
    final packageName = loadYaml(pubspec)['name'];
    if (!(packageName is String)) {
      throw PackageNameNotFoundException(
          'Could not find name of package located at "$pubspecPath"');
    }
    return packageName;
  }

  Future<String> _findNearestPubspecPath(Directory directory) async {
    var dirToSearch = directory;
    while (dirToSearch.parent != dirToSearch) {
      final files = await dirToSearch.list().toList();
      final pubspecs = files
          .whereType<File>()
          .where((file) => file.path.endsWith('pubspec.yaml'));
      if (pubspecs.isEmpty) {
        dirToSearch = dirToSearch.parent;
      }
      return pubspecs.first.path;
    }
    throw PackageNotFoundException(
        'Could not find any package at "$directory"');
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
