import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/models/dart_library_dependency.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:equatable/equatable.dart';

/// Representation of a Dart library
class DartLibrary extends Equatable {
  final String package;
  final String name;
  final List<DartClass> classes;
  final List<DartMethod> methods;
  final List<DartLibraryDependency> dependencies;

  DartLibrary({
    required this.name,
    required this.package,
    List<DartClass>? classes,
    List<DartMethod>? methods,
    List<DartLibraryDependency>? dependencies,
  })  : classes = classes ?? [],
        methods = methods ?? [],
        dependencies = dependencies ?? [];

  @override
  List<Object?> get props => [package, name, classes, methods, dependencies];

  @override
  String toString() {
    return 'DartLibrary(name="$name", package="$package", classes=$classes, methods=$methods, dependencies=$dependencies)';
  }
}
