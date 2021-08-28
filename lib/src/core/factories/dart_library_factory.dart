import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_class_factory.dart';
import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/models/dart_library.dart';
import 'package:arch_test/src/core/utils/uri_utils.dart';

class DartLibraryFactory {
  final DartClassFactory classFactory;
  final DartMethodFactory methodFactory;

  DartLibraryFactory(this.classFactory, this.methodFactory);

  DartLibrary fromLibraryMirror(LibraryMirror mirror) {
    final path = mirror.uri.toString();
    final package = UriUtils.getPackageName(mirror.uri);
    final name = path.replaceFirst('package:$package/', '');
    final classes = mirror.declarations.values
        .whereType<ClassMirror>()
        .map(classFactory.fromClassMirror)
        .toList(growable: false);
    final methods = mirror.declarations.values
        .whereType<MethodMirror>()
        .map(methodFactory.fromMethodMirror)
        .toList(growable: false);

    return DartLibrary(
      name: name,
      package: package,
      classes: classes,
      methods: methods,
    );
  }
}
