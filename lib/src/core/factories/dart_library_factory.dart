import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/factories/dart_class_factory.dart';
import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/models/dart_library.dart';
import 'package:arch_test/src/core/models/dart_library_dependency.dart';
import 'package:arch_test/src/core/models/enums/library_dependency_kind.dart';
import 'package:arch_test/src/core/utils/uri_utils.dart';
import 'package:path/path.dart';

class DartLibraryFactory {
  final DartClassFactory classFactory;
  final DartMethodFactory methodFactory;

  DartLibraryFactory(this.classFactory, this.methodFactory);

  DartLibrary fromLibraryMirror(LibraryMirror mirror) {
    final path = mirror.uri.toString();
    final package = UriUtils.getPackageName(mirror.uri);
    final name = UriUtils.getLibraryPath(path, package);

    return DartLibrary(
      name: name,
      package: package,
      classes: _getClasses(mirror),
      methods: _getMethods(mirror),
      dependencies: _getDependencies(mirror, dirname(path)),
    );
  }

  List<DartClass> _getClasses(LibraryMirror mirror) {
    return mirror.declarations.values
        .whereType<ClassMirror>()
        .map(classFactory.fromClassMirror)
        .toList(growable: false);
  }

  List<DartMethod> _getMethods(LibraryMirror mirror) {
    return mirror.declarations.values
        .whereType<MethodMirror>()
        .map(methodFactory.fromMethodMirror)
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
    path = normalize(path);
    final package = UriUtils.getPackageNameFromString(path);
    final name = UriUtils.getLibraryPath(path, package);
    final kind = mirror.isImport
        ? LibraryDependencyKind.IMPORT
        : LibraryDependencyKind.EXPORT;

    return DartLibraryDependency(
      kind: kind,
      package: package,
      library: name,
    );
  }
}
