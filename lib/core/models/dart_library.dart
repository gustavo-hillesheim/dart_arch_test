import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/dart_class.dart';
import 'package:arch_test/core/models/dart_declaration.dart';
import 'package:arch_test/core/models/dart_element.dart';
import 'package:arch_test/core/models/dart_elements_parent.dart';
import 'package:arch_test/core/models/dart_library_dependency.dart';
import 'package:arch_test/core/models/dart_method.dart';
import 'package:arch_test/core/models/element_location.dart';

/// Representation of a Dart library
class DartLibrary extends DartElement
    implements DartElementsParent<DartDeclaration> {
  final List<DartClass> classes;
  final List<DartMethod> methods;
  final List<DartVariable> variables;
  final List<DartLibraryDependency> dependencies;
  // Libraries are the top-most DartElement in a package, so they don't have a parent
  @override
  final DartElementRef? parentRef = null;

  DartLibrary({
    required String name,
    required ElementLocation location,
    DartElementRef? parentRef,
    this.classes = const [],
    this.methods = const [],
    this.variables = const [],
    this.dependencies = const [],
  }) : super(name: name, location: location);

  @override
  List<Object?> get props =>
      super.props + [classes, methods, variables, dependencies];

  @override
  List<DartDeclaration> get children => [...classes, ...methods, ...variables];
}
