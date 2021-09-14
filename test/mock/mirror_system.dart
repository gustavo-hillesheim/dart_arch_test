import 'dart:ffi';
import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/element_location.dart';
import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
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
    final library =
        FakeLibraryMirror(uri, declarations: {}, libraryDependencies: []);
    map[library.uri] = library;
  }
  return map;
}

final doubleDartType = DartType(
  name: 'double',
  generics: [],
  location: ElementLocation(uri: 'dart:core/double.dart', line: 1, column: 1),
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(
        uri: 'dart:core-patch/string_buffer_patch.dart', line: 1, column: 1),
  ),
);

final voidDartType = DartType(
  name: 'Void',
  generics: [],
  location:
      ElementLocation(uri: 'dart:ffi/native_type.dart', line: 1, column: 1),
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:ffi',
    location: ElementLocation(uri: 'dart:ffi/union.dart', line: 1, column: 1),
  ),
);

final intDartType = DartType(
  name: 'int',
  generics: [],
  location: ElementLocation(uri: 'dart:core/int.dart', line: 1, column: 1),
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(
        uri: 'dart:core-patch/string_buffer_patch.dart', line: 1, column: 1),
  ),
);

final stringDartType = DartType(
  name: 'String',
  generics: [],
  location: ElementLocation(uri: 'dart:core/string.dart', line: 1, column: 1),
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(
        uri: 'dart:core-patch/string_buffer_patch.dart', line: 1, column: 1),
  ),
);

/**
 * CLASSES
 */

class FakeMirrorSystem extends Mock implements MirrorSystem {}

class FakeLibraryMirror extends Mock implements LibraryMirror {
  final Uri uri;
  final Map<Symbol, DeclarationMirror> declarations;
  final List<LibraryDependencyMirror> libraryDependencies;

  FakeLibraryMirror(String uri,
      {required this.declarations, required this.libraryDependencies})
      : uri = Uri.parse(uri);
}

class FakeLibraryDependencyMirror extends Mock
    implements LibraryDependencyMirror {
  final bool isImport;
  final bool isExport;
  final LibraryMirror? targetLibrary;
  final LibraryMirror sourceLibrary;

  FakeLibraryDependencyMirror({
    required this.sourceLibrary,
    this.isImport = true,
    this.isExport = false,
    String? uri,
  }) : targetLibrary = uri != null
            ? FakeLibraryMirror(uri, declarations: {}, libraryDependencies: [])
            : null;
}

class FakeClassMirror extends Mock implements ClassMirror {
  final Symbol simpleName;
  final bool isAbstract;
  final bool isEnum;
  final Map<Symbol, DeclarationMirror> declarations;
  final SourceLocation? location;
  final ClassMirror? superclass;
  final List<ClassMirror> superinterfaces;
  final List<TypeMirror> typeArguments;
  final bool hasReflectedType;
  final Type reflectedType;

  FakeClassMirror(
    String name, {
    required String path,
    this.isAbstract = false,
    this.isEnum = false,
    this.declarations = const {},
    this.superinterfaces = const [],
    this.typeArguments = const [],
    this.superclass,
    Type? reflectedType,
  })  : simpleName = Symbol(name),
        location = FakeSourceLocation(path),
        hasReflectedType = reflectedType != null,
        reflectedType = reflectedType ?? Void;
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

  factory FakeMethodMirror.constructor(String name, ConstructorKind kind,
      {Type returnType = Void, TypeMirror? returnTypeMirror}) {
    return FakeMethodMirror(
      name,
      isRegularMethod: false,
      isConstructor: true,
      isConstConstructor: kind == ConstructorKind.CONST,
      isFactoryConstructor: kind == ConstructorKind.FACTORY,
      isGenerativeConstructor: kind == ConstructorKind.GENERATIVE,
      isRedirectingConstructor: kind == ConstructorKind.REDIRECTING,
      returnType: returnType,
      returnTypeMirror: returnTypeMirror,
    );
  }

  factory FakeMethodMirror.getter(String name, {Type returnType = Void}) {
    return FakeMethodMirror(name,
        isGetter: true, isRegularMethod: false, returnType: returnType);
  }
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
  final List<TypeMirror> typeArguments;
  final bool hasReflectedType;
  final Type reflectedType;
  final DeclarationMirror? owner;

  FakeTypeMirror(
    String name,
    String sourcePath, {
    List<TypeMirror>? typeArguments,
    Type? reflectedType,
    DeclarationMirror? owner,
  })  : simpleName = Symbol(name),
        location = FakeSourceLocation(sourcePath),
        typeArguments = typeArguments ?? [],
        hasReflectedType = reflectedType != null,
        reflectedType = reflectedType ?? Void,
        owner = owner;

  factory FakeTypeMirror.fromType(Type type, {List<Type>? typeArguments}) {
    final typeMirror = reflectType(type);
    final name = MirrorSystem.getName(typeMirror.simpleName);
    final path = typeMirror.location?.sourceUri.toString() ?? '';
    return FakeTypeMirror(
      name,
      path,
      typeArguments:
          typeArguments?.map((t) => FakeTypeMirror.fromType(t)).toList(),
      owner: typeMirror.owner,
    );
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
