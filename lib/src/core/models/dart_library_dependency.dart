import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_element.dart';
import 'package:arch_test/src/core/models/element_location.dart';
import 'package:arch_test/src/core/models/enums/library_dependency_kind.dart';
import 'package:arch_test/src/core/utils/uri_utils.dart';

/// Location for library dependencies is always unknown
class DartLibraryDependency extends DartElement {
  final LibraryDependencyKind kind;

  DartLibraryDependency({
    required String path,
    required ElementLocation location,
    required this.kind,
  }) : super(name: path, location: location);

  String get path => name;

  String get package => UriUtils.getPackageNameFromString(path);
  String get library => UriUtils.getLibraryPath(path);

  @override
  List<Object?> get props => super.props + [kind];
}
