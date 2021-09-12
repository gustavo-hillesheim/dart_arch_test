import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_element.dart';
import 'package:arch_test/src/core/models/element_location.dart';
import 'package:arch_test/src/core/models/enums/library_dependency_kind.dart';

class DartLibraryDependency extends DartElement {
  final LibraryDependencyKind kind;

  DartLibraryDependency({
    required String targetLibrary,
    required ElementLocation location,
    required this.kind,
  }) : super(name: targetLibrary, location: location);

  String get targetLibrary => name;

  @override
  List<Object?> get props => super.props + [kind];
}
