import 'dart:mirrors';

import 'package:arch_test/src/core/utils/mirror_utils.dart';

import 'models.dart';

/// Representation of a Dart type.
/// Can be from method return types, or variables types.
class DartType extends DartDeclaration {
  final List<DartType> generics;
  @override
  final DartElementRef? parentRef;

  DartType({
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

  factory DartType.voidType() {
    return DartType._coreType('void');
  }

  factory DartType.dynamicType() {
    return DartType._coreType('dynamic');
  }

  factory DartType._coreType(String name) {
    final package = DartPackage(name: 'unknown');
    final location = ElementLocation.unknown();
    final library = DartLibrary(
      name: 'unknown',
      location: location,
    );
    package.libraries.add(library);
    return DartType(
      name: name,
      location: location,
    );
  }

  static DartType from<T>() {
    return _fromMirror(reflectType(T));
  }

  static DartType _fromMirror(TypeMirror mirror) {
    final name = MirrorSystem.getName(mirror.simpleName);
    final generics = mirror.typeArguments.map(_fromMirror).toList();
    return DartType(
      name: name,
      generics: generics,
      location: MirrorUtils.elementLocation(mirror),
      parentRef: MirrorUtils.elementRef(mirror.owner),
      metadata: MirrorUtils.readMetadata(mirror),
    );
  }

  @override
  List<Object?> get props => super.props + [generics];

  @override
  String toString() {
    return 'DartType(name: $name, location: $location, generics: $generics, isTopLevel: $isTopLevel, metadata: $metadata, parentRef: $parentRef)';
  }
}
