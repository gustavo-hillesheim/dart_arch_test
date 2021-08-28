import 'dart:ffi';
import 'dart:mirrors';

import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:mocktail/mocktail.dart';

final Map<Uri, LibraryMirror> mockLibraries =
    createLibraryMirrorMap([...dartDefaultLibraries, ...fakePackageLibraries]);

final List<String> fakePackageLibraries = [
  'file:///C:/User/dart/fake_package/bin/fake_package.dart',
  'package:fake_package/fake_package.dart',
  'package:fake_package/component1.dart',
  'package:fake_package/component2.dart',
  'package:fake_package/services/service1.dart',
  'package:fake_package/services/service2.dart'
];

final List<String> dartDefaultLibraries = [
  'dart:core',
  'dart:isolate',
  'dart:mirrors',
  'dart:collection',
  'dart:async',
  'dart:developer',
  'dart:nativewrappers',
  'dart:typed_data',
  'dart:ffi',
  'dart:convert',
  'dart:_internal',
  'dart:math',
  'dart:io',
  'dart:_http',
  'dart:cli'
];

Map<Uri, LibraryMirror> createLibraryMirrorMap(List<String> urisStrs) {
  final map = <Uri, LibraryMirror>{};
  for (final uri in urisStrs) {
    final library = FakeLibraryMirror(uri, declarations: {});
    map[library.uri] = library;
  }
  return map;
}

final doubleDartType = DartType(
  name: 'double',
  package: 'dart:core',
  library: 'dart:core/double.dart',
);

final voidDartType = DartType(
  name: 'Void',
  package: 'dart:ffi',
  library: 'dart:ffi/native_type.dart',
);

final intDartType = DartType(
  name: 'int',
  package: 'dart:core',
  library: 'dart:core/int.dart',
);

final stringDartType = DartType(
  name: 'String',
  package: 'dart:core',
  library: 'dart:core/string.dart',
);

/**
 * CLASSES
 */

class FakeMirrorSystem extends Mock implements MirrorSystem {}

class FakeLibraryMirror extends Mock implements LibraryMirror {
  final Uri uri;
  final Map<Symbol, DeclarationMirror> declarations;

  FakeLibraryMirror(String uri, {required this.declarations})
      : uri = Uri.parse(uri);
}

class FakeClassMirror extends Mock implements ClassMirror {
  final Symbol simpleName;
  final bool isAbstract;
  final bool isEnum;
  final Map<Symbol, DeclarationMirror> declarations;

  FakeClassMirror(
    String name, {
    this.isAbstract = false,
    this.isEnum = false,
    this.declarations = const {},
  }) : simpleName = Symbol(name);
}

class FakeMethodMirror extends Mock implements MethodMirror {
  final Symbol simpleName;
  final bool isAbstract;
  final bool isStatic;
  final bool isConstructor;
  final bool isConstConstructor;
  final bool isFactoryConstructor;
  final bool isGenerativeConstructor;
  final bool isRedirectingConstructor;
  final bool isGetter;
  final bool isSetter;
  final bool isOperator;
  final bool isRegularMethod;
  final TypeMirror returnType;
  final List<ParameterMirror> parameters;

  FakeMethodMirror(
    String name, {
    this.isAbstract = false,
    this.isStatic = false,
    this.isConstructor = false,
    this.isConstConstructor = false,
    this.isFactoryConstructor = false,
    this.isGenerativeConstructor = false,
    this.isRedirectingConstructor = false,
    this.isGetter = false,
    this.isSetter = false,
    this.isOperator = false,
    this.isRegularMethod = true,
    this.parameters = const [],
    Type returnType = Void,
    TypeMirror? returnTypeMirror,
  })  : simpleName = Symbol(name),
        returnType = returnTypeMirror ?? FakeTypeMirror.fromType(returnType),
        assert(
            [isRegularMethod, isConstructor, isGetter, isSetter, isOperator]
                    .where((b) => b)
                    .length <
                2,
            'Only one method type is allowed');
}

class FakeVariableMirror extends Mock implements VariableMirror {
  final Symbol simpleName;
  final bool isConst;
  final bool isFinal;
  final bool isPrivate;
  final bool isStatic;
  final TypeMirror type;

  FakeVariableMirror(
    String name, {
    required Type type,
    this.isConst = false,
    this.isFinal = false,
    this.isPrivate = false,
    this.isStatic = false,
  })  : simpleName = Symbol(name),
        type = FakeTypeMirror.fromType(type);
}

class FakeTypeMirror extends Mock implements TypeMirror {
  final Symbol simpleName;
  final SourceLocation? location;

  FakeTypeMirror(String name, String sourcePath)
      : simpleName = Symbol(name),
        location = FakeSourceLocation(sourcePath);

  factory FakeTypeMirror.fromType(Type type) {
    final typeMirror = reflectType(type);
    final name = MirrorSystem.getName(typeMirror.simpleName);
    final path = typeMirror.location?.sourceUri.toString() ?? '';
    return FakeTypeMirror(name, path);
  }

  factory FakeTypeMirror.voidType() {
    return FakeTypeMirror.fromType(Void);
  }
}

class FakeParameterMirror extends Mock implements ParameterMirror {
  final Symbol simpleName;
  final bool isOptional;
  final bool isNamed;
  final bool isFinal;
  final bool isConst;
  final bool hasDefaultValue;
  final TypeMirror type;

  FakeParameterMirror(
    String name, {
    required Type type,
    this.isOptional = false,
    this.isNamed = false,
    this.isFinal = false,
    this.isConst = false,
    this.hasDefaultValue = false,
  })  : simpleName = Symbol(name),
        type = FakeTypeMirror.fromType(type);
}

class FakeSourceLocation implements SourceLocation {
  final Uri sourceUri;
  int get column => 1;
  int get line => 1;

  FakeSourceLocation(String path) : sourceUri = Uri.parse(path);
}
