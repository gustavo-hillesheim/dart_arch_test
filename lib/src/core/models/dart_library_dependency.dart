import 'package:arch_test/src/core/models/enums/library_dependency_kind.dart';
import 'package:equatable/equatable.dart';

class DartLibraryDependency extends Equatable {
  final LibraryDependencyKind kind;
  final String package;
  final String library;

  DartLibraryDependency({
    required this.kind,
    required this.package,
    required this.library,
  });

  @override
  List<Object?> get props => [kind, package, library];

  @override
  String toString() {
    return 'DartLibraryDependency(kind=$kind, package="$package", library="$library")';
  }
}
