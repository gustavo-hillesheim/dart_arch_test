import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/models/dart_element.dart';
import 'package:arch_test/src/core/models/dart_library_dependency.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/element_location.dart';

/// Representation of a Dart library
class DartLibrary extends DartElement {
  final DartPackage package;
  final List<DartClass> classes;
  final List<DartMethod> methods;
  final List<DartLibraryDependency> dependencies;

  DartLibrary({
    required String name,
    required ElementLocation location,
    required this.package,
    required this.classes,
    required this.methods,
    required this.dependencies,
  }) : super(name: name, location: location, parent: null);

  @override
  List<Object?> get props =>
      super.props + [package, classes, methods, dependencies];
}
