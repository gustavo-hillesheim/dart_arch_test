import 'dart:io';

import 'package:arch_test/src/exception.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

Future<Directory> findNearestPackageDirectory(Directory directory) async {
  var dirToSearch = directory;
  while (dirToSearch.parent != dirToSearch) {
    if (await _hasPubspecFile(dirToSearch)) {
      return dirToSearch;
    }
    dirToSearch = dirToSearch.parent;
  }
  throw PackageNotFoundException('Could not find any package at "$directory"');
}

Future<String> findPackageName(Directory directory) async {
  final pubspecPath = '${directory.path}${separator}pubspec.yaml';
  final file = File(pubspecPath);
  final content = await file.readAsString();
  final parsedContent = loadYaml(content);
  return parsedContent['name'];
}

Future<bool> _hasPubspecFile(Directory directory) async {
  final files = await directory.list().toList();
  final pubspecs = files
      .whereType<File>()
      .where((file) => file.path.endsWith('pubspec.yaml'));
  return pubspecs.isNotEmpty;
}

class NearestPackage {
  final String name;
  final Directory directory;

  NearestPackage({required this.name, required this.directory});
}
