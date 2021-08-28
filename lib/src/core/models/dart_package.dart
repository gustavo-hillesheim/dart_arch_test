import 'package:arch_test/src/core/models/dart_library.dart';

/// Representation of a Dart package
class DartPackage {
  final String name;
  final List<DartLibrary> libraries;

  DartPackage({required this.name, List<DartLibrary>? libraries})
      : libraries = libraries ?? [];
}
