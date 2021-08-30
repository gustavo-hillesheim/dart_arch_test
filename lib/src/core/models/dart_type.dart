import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:equatable/equatable.dart';

/// Representation of a Dart type.
/// Can be from method return types, or variables types.
class DartType extends Equatable {
  final String name;
  final String package;
  final String library;
  final List<DartType> generics;

  DartType({
    required this.name,
    required this.package,
    required this.library,
    List<DartType>? generics,
  }) : generics = generics ?? [];

  factory DartType.voidType() {
    return DartType(name: 'void', package: '', library: 'unknown');
  }

  factory DartType.from(Type type, {List<DartType>? generics}) {
    const factory = DartTypeFactory();
    final dartType = factory.fromTypeMirror(reflectType(type));
    return DartType(
      name: dartType.name,
      package: dartType.package,
      library: dartType.library,
      generics: generics,
    );
  }

  @override
  List<Object?> get props => [name, package, library, generics];

  @override
  String toString() {
    return 'DartType(name="$name", package="$package", library="$library", generics=$generics)';
  }
}
