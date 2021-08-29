import 'package:arch_test/src/core/models/dart_library.dart';
import 'package:equatable/equatable.dart';

/// Representation of a Dart package
class DartPackage extends Equatable {
  final String name;
  final List<DartLibrary> libraries;

  DartPackage({required this.name, List<DartLibrary>? libraries})
      : libraries = libraries ?? [];

  @override
  List<Object?> get props => [name, libraries];

  @override
  String toString() {
    return 'DartPackage(name="$name", libraries=$libraries)';
  }
}
