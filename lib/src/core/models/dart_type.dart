import 'dart:mirrors';

import '../mappers/mappers.dart';
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
    final dartType = TypeMirrorMapper.instance.toDartType(reflectType(T));
    return DartType(
      name: dartType.name,
      location: dartType.location,
      generics: dartType.generics,
      parentRef: dartType.parentRef,
    );
  }

  @override
  List<Object?> get props => super.props + [generics];
}
