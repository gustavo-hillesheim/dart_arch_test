import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/dart_element.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:arch_test/core/models/enums/library_dependency_kind.dart';
import 'package:arch_test/core/utils/uri_utils.dart';

/// Location for library dependencies is always unknown
class DartLibraryDependency extends DartElement {
  final LibraryDependencyKind kind;
  @override
  final DartElementRef<DartLibrary>? parentRef;

  DartLibraryDependency({
    required String path,
    required ElementLocation location,
    required this.parentRef,
    required this.kind,
  }) : super(name: path, location: location);

  String get path => name;

  String get targetPackage => UriUtils.getPackageNameFromString(path);
  String get targetLibrary => UriUtils.getLibraryPath(path);

  @override
  List<Object?> get props => super.props + [kind];
}
