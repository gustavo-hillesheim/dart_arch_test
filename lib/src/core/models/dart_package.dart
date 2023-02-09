import 'models.dart';
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

  @override
  String toString() {
    return 'DartPackage(name: "$name", libraries: $libraries)';
  }
}
