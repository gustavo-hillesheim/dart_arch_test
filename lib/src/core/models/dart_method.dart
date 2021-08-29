import 'package:arch_test/src/core/models/dart_parameter.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:arch_test/src/core/models/enums/method_kind.dart';
import 'package:equatable/equatable.dart';

class DartMethod extends Equatable {
  final String name;
  final bool isAbstract;
  final bool isStatic;
  final DartType returnType;
  final MethodKind kind;
  final ConstructorKind? constructorKind;
  final List<DartParameter> parameters;

  DartMethod({
    required this.name,
    required this.returnType,
    this.constructorKind,
    List<DartParameter>? parameters,
    this.kind = MethodKind.REGULAR,
    this.isAbstract = false,
    this.isStatic = false,
  })  : parameters = parameters ?? [],
        assert(kind != MethodKind.CONSTRUCTOR || constructorKind != null,
            'If kind is CONSTRUCTOR, then a constructorKind must be specified');

  @override
  List<Object?> get props => [
        name,
        isAbstract,
        isStatic,
        returnType,
        kind,
        constructorKind,
        parameters
      ];

  @override
  String toString() {
    return 'DartMethod(name="$name", isAbstract=$isAbstract, isStatic=$isStatic, returnType=$returnType, kind=$kind, constructorKind=$constructorKind, parameters=$parameters)';
  }
}
