import 'package:arch_test/core/core.dart';
import 'package:arch_test/core/models/dart_library.dart';
import 'package:equatable/equatable.dart';

/// Representation of a Dart package
class DartPackage extends Equatable implements DartElementsParent {
  final String name;
  final List<DartLibrary> libraries;

  DartPackage({required this.name, List<DartLibrary>? libraries})
      : libraries = libraries ?? [];

  @override
  List<Object?> get props => [name, libraries];

  @override
  List<DartElement> get children => libraries;
}
