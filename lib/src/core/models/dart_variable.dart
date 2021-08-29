import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:equatable/equatable.dart';

/// Representation of a Dart variable.
/// Can be fields of a class, parameters or top level variables.
class DartVariable extends Equatable {
  final String name;
  final bool isFinal;
  final bool isConst;
  final bool isPrivate;
  final bool isStatic;
  final DartType type;

  DartVariable({
    required this.name,
    required this.type,
    this.isFinal = false,
    this.isConst = false,
    this.isPrivate = false,
    this.isStatic = false,
  });

  @override
  List<Object?> get props =>
      [name, isFinal, isConst, isPrivate, isStatic, type];

  @override
  String toString() {
    return 'DartVariable(name="$name", isFinal=$isFinal, isConst=$isConst, isPrivate=$isPrivate, isStatic=$isStatic, type=$type)';
  }
}
