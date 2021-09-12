import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/models/dart_element.dart';
import 'package:arch_test/src/core/models/element_location.dart';

/// Representation of a Dart type.
/// Can be from method return types, or variables types.
class DartType extends DartElement {
  final List<DartType> generics;

  DartType({
    required String name,
    required DartLibrary library,
    required ElementLocation location,
    required this.generics,
  }) : super(name: name, parent: library, location: location);

  DartLibrary get library => parent as DartLibrary;

  factory DartType.voidType() {
    return DartType._coreType('void');
  }

  factory DartType.dynamicType() {
    return DartType._coreType('dynamic');
  }

  factory DartType._coreType(String name) {
    final package = DartPackage(name: 'unknown', libraries: []);
    final location = ElementLocation(uri: 'unknown', column: 1, row: 1);
    final library = DartLibrary(
      name: 'unknown',
      classes: [],
      dependencies: [],
      methods: [],
      package: package,
      location: location,
    );
    package.libraries.add(library);
    return DartType(
      name: name,
      library: library,
      location: location,
      generics: [],
    );
  }

  factory DartType.from(Type type, {List<DartType>? generics}) {
    const factory = DartTypeFactory();
    final dartType = factory.fromTypeMirror(reflectType(type));
    return DartType(
      name: dartType.name,
      library: dartType.library,
      location: dartType.location,
      generics: generics ?? [],
    );
  }

  @override
  List<Object?> get props => super.props + [generics];
}
