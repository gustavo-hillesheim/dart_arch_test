import 'models.dart';
import '../utils/uri_utils.dart';

/// Location for library dependencies is always unknown
class DartLibraryDependency extends DartElement {
  final LibraryDependencyKind kind;
  @override
  final DartElementRef<DartLibrary>? parentRef;

  DartLibraryDependency({
    required String path,
    required ElementLocation location,
    required this.kind,
    this.parentRef,
  }) : super(name: path, location: location);

  String get path => name;

  String get targetPackage => UriUtils.getPackageNameFromString(path);
  String get targetLibrary => UriUtils.getLibraryPath(path);

  @override
  List<Object?> get props => super.props + [kind];

  @override
  String toString() {
    return 'DartLibraryDependency(path: $path, location: $location, kind: $kind, parentRef: $parentRef)';
  }
}
