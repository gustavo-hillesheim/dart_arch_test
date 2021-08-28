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
  final ConstructorKind? constructorType;
  final List<DartParameter> parameters;

  DartMethod({
    required this.name,
    required this.returnType,
    required this.parameters,
    this.constructorType,
    this.kind = MethodKind.REGULAR,
    this.isAbstract = false,
    this.isStatic = false,
  });

  @override
  List<Object?> get props => [
        name,
        isAbstract,
        isStatic,
        returnType,
        kind,
        constructorType,
        parameters
      ];
}
