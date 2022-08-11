import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart' hide ElementLocation;
import 'package:arch_test/src/core/utils/element_utils.dart';

import 'dart_class_mapper.dart';
import 'dart_method_mapper.dart';
import 'dart_variable_mapper.dart';
import '../models/models.dart';
import '../utils/uri_utils.dart';
import 'package:path/path.dart';

class DartLibraryMapper {
  static late DartLibraryMapper instance = DartLibraryMapper(
    DartClassMapper.instance,
    DartMethodMapper.instance,
    DartVariableMapper.instance,
  );

  final DartClassMapper dartClassMapper;
  final DartMethodMapper dartMethodMapper;
  final DartVariableMapper dartVariableMapper;

  DartLibraryMapper(
    this.dartClassMapper,
    this.dartMethodMapper,
    this.dartVariableMapper,
  );

  DartLibrary fromResolvedLibrary(ResolvedLibraryResult resolvedLibrary) {
    final uri = resolvedLibrary.element.librarySource.uri;
    final path = uri.toString();
    final package = UriUtils.getPackageName(uri);
    final name = UriUtils.getLibraryPath(path, package);

    return DartLibrary(
      name: name,
      location: ElementUtils.elementLocation(resolvedLibrary.element),
      classes: _getClasses(resolvedLibrary),
      methods: _getMethods(resolvedLibrary),
      variables: _getVariables(resolvedLibrary),
      dependencies: _getDependencies(resolvedLibrary, dirname(path)),
    );
  }

  List<DartClass> _getClasses(ResolvedLibraryResult resolvedLibrary) {
    return _foldUnits(resolvedLibrary, (unit) => unit.classes)
        .map(dartClassMapper.fromClassElement)
        .toList(growable: false);
  }

  List<DartMethod> _getMethods(ResolvedLibraryResult resolvedLibrary) {
    return _foldUnits(resolvedLibrary, (unit) => unit.functions)
        .map(dartMethodMapper.fromFunctionElement)
        .toList(growable: false);
  }

  List<DartVariable> _getVariables(ResolvedLibraryResult resolvedLibrary) {
    return _foldUnits(resolvedLibrary, (unit) => unit.topLevelVariables)
        .map(dartVariableMapper.fromVariableElement)
        .toList(growable: false);
  }

  List<DartLibraryDependency> _getDependencies(
      ResolvedLibraryResult resolvedLibrary, String basePath) {
    final imports = resolvedLibrary.element.imports
        .where(librarySchemeFilter)
        .where((i) => !i.isSynthetic)
        .map((i) => _createLibraryDependency(
              i,
              i.importedLibrary!,
              basePath,
              LibraryDependencyKind.IMPORT,
              resolvedLibrary,
            ))
        .toList(growable: false);
    final exports = resolvedLibrary.element.exports
        .where(librarySchemeFilter)
        .where((e) => !e.isSynthetic)
        .map((e) => _createLibraryDependency(
              e,
              e.exportedLibrary!,
              basePath,
              LibraryDependencyKind.EXPORT,
              resolvedLibrary,
            ))
        .toList(growable: false);
    return [...imports, ...exports];
  }

  DartLibraryDependency _createLibraryDependency(
    UriReferencedElement importOrExport,
    LibraryElement library,
    String basePath,
    LibraryDependencyKind kind,
    ResolvedLibraryResult parent,
  ) {
    var path = library.librarySource.uri.toString();
    if (!path.startsWith('package:') && !path.startsWith('dart:')) {
      path = join(basePath, path);
    }
    path = normalize(path).replaceAll(separator, '/');

    return DartLibraryDependency(
      kind: kind,
      path: path,
      location: ElementUtils.elementLocation(importOrExport),
      parentRef: ElementUtils.elementRef(parent.element),
    );
  }

  bool librarySchemeFilter(UriReferencedElement lib) {
    if (lib.librarySource.uri.isScheme('file')) {
      print(
          'WARNING: Library dependencies using "file" scheme are not supported. Encountered in file "${lib.librarySource.uri}"');
      return false;
    }
    return true;
  }

  List<T> _foldUnits<T>(ResolvedLibraryResult resolvedLibrary,
      List<T> Function(CompilationUnitElement) elementFinder) {
    return resolvedLibrary.element.units
        .map(elementFinder)
        .fold<List<T>>([], (acc, elements) => [...acc, ...elements]);
  }
}
