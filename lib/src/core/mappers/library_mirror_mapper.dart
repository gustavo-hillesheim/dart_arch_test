import 'dart:mirrors';

import 'class_mirror_mapper.dart';
import 'method_mirror_mapper.dart';
import 'variable_mirror_mapper.dart';
import '../models/models.dart';
import '../utils/mirror_utils.dart';
import '../utils/uri_utils.dart';
import 'package:path/path.dart';

class LibraryMirrorMapper {
  static late LibraryMirrorMapper instance = LibraryMirrorMapper(
    ClassMirrorMapper.instance,
    MethodMirrorMapper.instance,
    VariableMirrorMapper.instance,
  );

  final ClassMirrorMapper classMirrorMapper;
  final MethodMirrorMapper methodMirrorMapper;
  final VariableMirrorMapper variableMirrorMapper;

  LibraryMirrorMapper(
    this.classMirrorMapper,
    this.methodMirrorMapper,
    this.variableMirrorMapper,
  );

  DartLibrary toDartLibrary(LibraryMirror mirror) {
    final path = mirror.uri.toString();
    final package = UriUtils.getPackageName(mirror.uri);
    final name = UriUtils.getLibraryPath(path, package);

    return DartLibrary(
      name: name,
      location: MirrorUtils.elementLocation(mirror),
      classes: _getClasses(mirror),
      methods: _getMethods(mirror),
      variables: _getVariables(mirror),
      dependencies: _getDependencies(mirror, dirname(path)),
    );
  }

  List<DartClass> _getClasses(LibraryMirror mirror) {
    return mirror.declarations.values
        .whereType<ClassMirror>()
        .map(classMirrorMapper.toDartClass)
        .toList(growable: false);
  }

  List<DartMethod> _getMethods(LibraryMirror mirror) {
    return mirror.declarations.values
        .whereType<MethodMirror>()
        .map(methodMirrorMapper.toDartMethod)
        .toList(growable: false);
  }

  List<DartVariable> _getVariables(LibraryMirror mirror) {
    return mirror.declarations.values
        .whereType<VariableMirror>()
        .map(variableMirrorMapper.toDartVariable)
        .toList(growable: false);
  }

  List<DartLibraryDependency> _getDependencies(
      LibraryMirror mirror, String basePath) {
    return mirror.libraryDependencies
        .where((dep) => dep.targetLibrary != null)
        .where((dep) {
          if (dep.targetLibrary!.uri.isScheme('file')) {
            print(
                'WARNING: Library dependencies using "file" scheme are not supported. Encountered in file "${mirror.uri}"');
            return false;
          }
          return true;
        })
        .map((dep) => _createLibraryDependency(dep, basePath))
        .toList(growable: false);
  }

  DartLibraryDependency _createLibraryDependency(
    LibraryDependencyMirror mirror,
    String basePath,
  ) {
    var path = mirror.targetLibrary!.uri.toString();
    if (!path.startsWith('package:') && !path.startsWith('dart:')) {
      path = join(basePath, path);
    }
    path = normalize(path).replaceAll(separator, '/');
    final kind = mirror.isImport
        ? LibraryDependencyKind.IMPORT
        : LibraryDependencyKind.EXPORT;

    return DartLibraryDependency(
      kind: kind,
      path: path,
      location: MirrorUtils.dependencyElementLocation(mirror),
      parentRef: MirrorUtils.elementRef<DartLibrary>(mirror.sourceLibrary),
    );
  }
}
