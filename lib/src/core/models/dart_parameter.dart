import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/enums/parameter_kind.dart';
import 'package:equatable/equatable.dart';

class DartParameter extends Equatable {
  final String name;
  final DartType type;
  final bool hasDefaultValue;
  final bool isConst;
  final bool isFinal;
  final ParameterKind kind;

  DartParameter({
    required this.name,
    required this.type,
    this.hasDefaultValue = false,
    this.isConst = false,
    this.isFinal = false,
    this.kind = ParameterKind.REGULAR,
  });

  @override
  List<Object?> get props =>
      [name, type, hasDefaultValue, isConst, isFinal, kind];

  @override
  String toString() {
    return 'DartParameter(name="$name", type=$type, hasDefaultValue=$hasDefaultValue, isConst=$isConst, isFinal=$isFinal, kind=$kind)';
  }
}
