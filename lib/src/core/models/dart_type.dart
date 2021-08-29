import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:equatable/equatable.dart';

/// Representation of a Dart type.
/// Can be from method return types, or variables types.
class DartType extends Equatable {
  final String name;
  final String package;
  final String library;

  DartType({
    required this.name,
    required this.package,
    required this.library,
  });

  factory DartType.voidType() {
    return DartType(name: 'void', package: '', library: 'unknown');
  }

  factory DartType.from(Type type) {
    return DartTypeFactory().fromTypeMirror(reflectType(type));
  }

  @override
  List<Object?> get props => [name, package, library];

  @override
  String toString() {
    return 'DartType(name="$name", package="$package", library="$library")';
  }
}
