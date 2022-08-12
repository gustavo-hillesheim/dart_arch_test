import '../utils/uri_utils.dart';
import 'package:equatable/equatable.dart';

class ElementLocation extends Equatable {
  final String uri;

  const ElementLocation({required this.uri});

  /// Useful when a Mirror does not have a SourceLocation, or representing
  /// types that don't have a class (void, dynamic, etc)
  factory ElementLocation.unknown() {
    return ElementLocation(uri: 'unknown');
  }

  String get package => UriUtils.getPackageNameFromString(uri);
  String get library => UriUtils.getLibraryPath(uri);

  @override
  List<Object?> get props => [uri];

  @override
  String toString() {
    return 'ElementLocation(uri: "$uri")';
  }
}
