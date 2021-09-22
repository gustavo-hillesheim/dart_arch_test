import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:arch_test/core/utils/uri_utils.dart';
import 'package:arch_test/core/exception.dart';

class MirrorUtils {
  static DartElementRef<T>? elementRef<T extends DartElement>(
      DeclarationMirror? mirror) {
    if (mirror == null) {
      return null;
    }
    if (mirror is ClassMirror) {
      return _createElementRef<DartClass>(mirror) as DartElementRef<T>;
    } else if (mirror is MethodMirror) {
      if (mirror.isConstructor) {
        return _createElementRef<DartConstructor>(mirror) as DartElementRef<T>;
      } else {
        return _createElementRef<DartMethod>(mirror) as DartElementRef<T>;
      }
    } else if (mirror is LibraryMirror) {
      return _createElementRef<DartLibrary>(mirror) as DartElementRef<T>;
    } else if (mirror is VariableMirror) {
      return _createElementRef<DartVariable>(mirror) as DartElementRef<T>;
    } else if (mirror is ParameterMirror) {
      return _createElementRef<DartParameter>(mirror) as DartElementRef<T>;
    } else if (mirror is TypeMirror) {
      return _createElementRef<DartType>(mirror) as DartElementRef<T>;
    } else if (mirror is LibraryDependencyMirror) {
      return _createElementRef<DartLibraryDependency>(mirror)
          as DartElementRef<T>;
    } else {
      throw UnsupportedMirrorType(mirror.runtimeType);
    }
  }

  static DartElementRef<T> _createElementRef<T extends DartElement>(
      DeclarationMirror mirror) {
    late String name;
    if (mirror is LibraryMirror) {
      name = UriUtils.getLibraryPath(mirror.uri.toString());
    } else {
      name = MirrorSystem.getName(mirror.simpleName);
    }
    return DartElementRef<T>(
      name: name,
      location: elementLocation(mirror),
    );
  }

  static ElementLocation dependencyElementLocation(
      LibraryDependencyMirror mirror) {
    try {
      return _elementLocation(mirror.location);
    } on UnsupportedError {
      return ElementLocation.unknown();
    }
  }

  static ElementLocation elementLocation(DeclarationMirror mirror) {
    try {
      return _elementLocation(mirror.location);
    } on UnsupportedError {
      return ElementLocation.unknown();
    }
  }

  static ElementLocation _elementLocation(SourceLocation? sourceLocation) {
    if (sourceLocation == null) {
      return ElementLocation.unknown();
    }

    return ElementLocation(
      uri: sourceLocation.sourceUri.toString(),
      column: sourceLocation.column,
      line: sourceLocation.line,
    );
  }
}