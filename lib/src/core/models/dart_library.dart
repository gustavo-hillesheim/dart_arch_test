import 'models.dart';

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

  @override
  String toString() {
    return 'DartLibrary(name: "$name", location: $location, dependencies: $dependencies, variables: $variables, methods: $methods, classes: $classes, parentRef: $parentRef)';
  }
}
