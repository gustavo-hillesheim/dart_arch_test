import 'package:arch_test/core/utils/uri_utils.dart';
import 'package:equatable/equatable.dart';

class ElementLocation extends Equatable {
  final String uri;
  final int column;
  final int line;

  ElementLocation(
      {required this.uri, required this.column, required this.line});

  /// Useful when a Mirror does not have a SourceLocation, or representing
  /// types that don't have a class (void, dynamic, etc)
  factory ElementLocation.unknown() {
    return ElementLocation(uri: 'unknown', column: 1, line: 1);
  }

  String get package => UriUtils.getPackageNameFromString(uri);
  String get library => UriUtils.getLibraryPath(uri);

  @override
  List<Object?> get props => [uri, column, line];
}
