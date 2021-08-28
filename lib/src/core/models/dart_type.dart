import 'package:equatable/equatable.dart';

/// Representation of a Dart type.
/// Can be from method return types, or variables types.
class DartType extends Equatable {
  final String name;
  final String package;
  final String library;

  DartType({
    required this.name,
    required this.package,
    required this.library,
  });

  @override
  List<Object?> get props => [name, package, library];
}
