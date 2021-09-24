import 'dart:io';

import 'package:arch_test/src/exception.dart';
import 'package:yaml/yaml.dart';

Future<String> findNearestPackageName(Directory directory) async {
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
  throw PackageNotFoundException('Could not find any package at "$directory"');
}
