import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/mappers/mappers.dart';
import 'package:arch_test/core/models/dart_element.dart';
import 'package:arch_test/core/models/element_location.dart';

/// Representation of a Dart type.
/// Can be from method return types, or variables types.
class DartType extends DartElement {
  final List<DartType> generics;
  @override
  final DartElementRef? parentRef;

  DartType({
    required String name,
    required ElementLocation location,
    required this.parentRef,
    required this.generics,
  }) : super(name: name, location: location);

  factory DartType.voidType() {
    return DartType._coreType('void');
  }

  factory DartType.dynamicType() {
    return DartType._coreType('dynamic');
  }

  factory DartType._coreType(String name) {
    final package = DartPackage(name: 'unknown', libraries: []);
    final location = ElementLocation.unknown();
    final library = DartLibrary(
      name: 'unknown',
      classes: [],
      dependencies: [],
      methods: [],
      location: location,
      parentRef: null,
    );
    package.libraries.add(library);
    return DartType(
      name: name,
      location: location,
      generics: [],
      parentRef: null,
    );
  }

  static DartType from<T>() {
    const factory = TypeMirrorMapper();
    final dartType = factory.toDartType(reflectType(T));
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