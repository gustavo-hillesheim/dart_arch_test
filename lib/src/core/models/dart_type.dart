import 'package:arch_test/arch_test.dart';

/// Representation of a Dart type.
/// Can be from method return types, or variables types.
class DartType extends DartDeclaration {
  // TODO: Adicionar possibilidade de tipos genéricos
  static const futureType = _futureType;
  static const futureOrType = _futureOrType;
  static const streamType = _streamType;
  static const boolType = _boolType;
  static const doubleType = _doubleType;
  static const enumType = _enumType;
  static const functionType = _functionType;
  static const intType = _intType;
  static const iterableType = _iterableType;
  static const listType = _listType;
  static const mapType = _mapType;
  static const nullType = _nullType;
  static const numType = _numType;
  static const objectType = _objectType;
  static const setType = _setType;
  static const stringType = _stringType;
  static const symbolType = _symbolType;
  static const dynamicType = _dynamicType;
  static const voidType = _voidType;

  final List<DartType> generics;
  @override
  final DartElementRef? parentRef;

  const DartType({
    required String name,
    required ElementLocation location,
    this.parentRef,
    this.generics = const [],
    List<DartMetadata> metadata = const [],
    bool isTopLevel = false,
  }) : super(
          name: name,
          location: location,
          isTopLevel: isTopLevel,
          metadata: metadata,
        );

  static ResolvableDartType from<T>({
    String? name,
    String? package,
    String? library,
  }) {
    // TODO: Melhorar resolução de tipos com generics para considerar os generics também
    return ResolvableDartType(
      name: name ?? T.toString(),
      package: package,
      library: library,
    );
  }

  @override
  List<Object?> get props => super.props + [generics];

  @override
  String toString() {
    return 'DartType(name: "$name", location: $location, generics: $generics, isTopLevel: $isTopLevel, metadata: $metadata, parentRef: $parentRef)';
  }
}

class ResolvableDartType {
  final String name;
  final String? package;
  final String? library;

  const ResolvableDartType({
    required this.name,
    this.package,
    this.library,
  });

  DartType resolve(DartPackage package) {
    final dartType = DartElementFinder.instance.findOneByMatcher<DartType>(
      matcher: (el) {
        return el is DartType &&
            el.name == name &&
            (this.package == null || el.package == this.package) &&
            (library == null || el.library == library);
      },
      source: package,
    );
    if (dartType == null) {
      throw DartTypeNotFoundException(
        name: name,
        package: this.package,
        library: library,
      );
    }
    return dartType;
  }
}

const _futureType = DartType(
  name: 'Future',
  location: ElementLocation(uri: 'dart:async/future.dart'),
  generics: [
    DartType(
      name: 'dynamic',
      location: ElementLocation(uri: 'dynamic'),
      generics: [],
      isTopLevel: false,
      metadata: [],
      parentRef: null,
    ),
  ],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:async',
    location: ElementLocation(uri: 'dart:async'),
  ),
);

const _futureOrType = DartType(
  name: 'FutureOr',
  location: ElementLocation(uri: 'dart:async/future.dart'),
  generics: [
    DartType(
      name: 'dynamic',
      location: ElementLocation(uri: 'dynamic'),
      generics: [],
      isTopLevel: false,
      metadata: [],
      parentRef: null,
    ),
  ],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:async',
    location: ElementLocation(uri: 'dart:async'),
  ),
);

const _streamType = DartType(
  name: 'Stream',
  location: ElementLocation(uri: 'dart:async/stream.dart'),
  generics: [
    DartType(
      name: 'dynamic',
      location: ElementLocation(uri: 'dynamic'),
      generics: [],
      isTopLevel: false,
      metadata: [],
      parentRef: null,
    ),
  ],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:async',
    location: ElementLocation(uri: 'dart:async'),
  ),
);

const _boolType = DartType(
  name: 'bool',
  location: ElementLocation(uri: 'dart:core/bool.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _doubleType = DartType(
  name: 'double',
  location: ElementLocation(uri: 'dart:core/double.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _intType = DartType(
  name: 'int',
  location: ElementLocation(uri: 'dart:core/int.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _numType = DartType(
  name: 'num',
  location: ElementLocation(uri: 'dart:core/num.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _enumType = DartType(
  name: 'Enum',
  location: ElementLocation(uri: 'dart:core/enum.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [
    DartMetadata(metadata: 'Since (version = String (\'2.14\'))'),
  ],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _functionType = DartType(
  name: 'Function',
  location: ElementLocation(uri: 'dart:core/function.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _iterableType = DartType(
  name: 'Iterable',
  location: ElementLocation(uri: 'dart:core/iterable.dart'),
  generics: [
    DartType(
      name: 'dynamic',
      location: ElementLocation(uri: 'dynamic'),
      generics: [],
      isTopLevel: false,
      metadata: [],
      parentRef: null,
    ),
  ],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _listType = DartType(
  name: 'List',
  location: ElementLocation(uri: 'dart:core/list.dart'),
  generics: [
    DartType(
      name: 'dynamic',
      location: ElementLocation(uri: 'dynamic'),
      generics: [],
      isTopLevel: false,
      metadata: [],
      parentRef: null,
    ),
  ],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _mapType = DartType(
  name: 'Map',
  location: ElementLocation(uri: 'dart:core/map.dart'),
  generics: [
    DartType(
      name: 'dynamic',
      location: ElementLocation(uri: 'dynamic'),
      generics: [],
      isTopLevel: false,
      metadata: [],
      parentRef: null,
    ),
    DartType(
      name: 'dynamic',
      location: ElementLocation(uri: 'dynamic'),
      generics: [],
      isTopLevel: false,
      metadata: [],
      parentRef: null,
    ),
  ],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _nullType = DartType(
  name: 'Null',
  location: ElementLocation(uri: 'dart:core/null.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _objectType = DartType(
  name: 'Object',
  location: ElementLocation(uri: 'dart:core/object.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _setType = DartType(
  name: 'Set',
  location: ElementLocation(uri: 'dart:core/set.dart'),
  generics: [
    DartType(
      name: 'dynamic',
      location: ElementLocation(uri: 'dynamic'),
      generics: [],
      isTopLevel: false,
      metadata: [],
      parentRef: null,
    ),
  ],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _stringType = DartType(
  name: 'String',
  location: ElementLocation(uri: 'dart:core/string.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _symbolType = DartType(
  name: 'Symbol',
  location: ElementLocation(uri: 'dart:core/symbol.dart'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: DartElementRef<DartLibrary>(
    name: 'dart:core',
    location: ElementLocation(uri: 'dart:core'),
  ),
);

const _dynamicType = DartType(
  name: 'dynamic',
  location: ElementLocation(uri: 'dynamic'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: null,
);

const _voidType = DartType(
  name: 'void',
  location: ElementLocation(uri: 'unknown'),
  generics: [],
  isTopLevel: false,
  metadata: [],
  parentRef: null,
);
