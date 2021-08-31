import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/factories/dart_variable_factory.dart';
import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/utils/uri_utils.dart';

class DartClassFactory {
  final DartVariableFactory variableFactory;
  final DartMethodFactory methodFactory;
  final DartTypeFactory typeFactory;

  DartClassFactory(this.variableFactory, this.methodFactory, this.typeFactory);

  DartClass fromClassMirror(ClassMirror mirror) {
    final simpleName = MirrorSystem.getName(mirror.simpleName);
    final library = UriUtils.getLibraryPathFromSourceLocation(mirror.location);
    final package = mirror.location != null
        ? UriUtils.getPackageName(mirror.location!.sourceUri)
        : '';
    final fields = mirror.declarations.values
        .whereType<VariableMirror>()
        .map(variableFactory.fromVariableMirror)
        .toList(growable: false);
    final methods = mirror.declarations.values
        .whereType<MethodMirror>()
        .map(methodFactory.fromMethodMirror)
        .toList(growable: false);
    final superClass = mirror.superclass != null &&
            (!mirror.superclass!.hasReflectedType ||
                mirror.superclass!.reflectedType != Object)
        ? fromClassMirror(mirror.superclass!)
        : null;
    final superInterfaces =
        mirror.superinterfaces.map(fromClassMirror).toList();
    final generics =
        mirror.typeArguments.map(typeFactory.fromTypeMirror).toList();

    return DartClass(
      name: simpleName,
      library: library,
      package: package,
      generics: generics,
      isAbstract: mirror.isAbstract,
      isEnum: mirror.isEnum,
      fields: fields,
      methods: methods,
      superClass: superClass,
      superInterfaces: superInterfaces,
    );
  }
}
