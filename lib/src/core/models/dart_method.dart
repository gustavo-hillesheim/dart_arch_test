import 'package:arch_test/src/core/models/dart_element.dart';
import 'package:arch_test/src/core/models/dart_parameter.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/element_location.dart';
import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:arch_test/src/core/models/enums/method_kind.dart';

class DartMethod extends DartElement {
  final bool isAbstract;
  final bool isStatic;
  final DartType returnType;
  final MethodKind kind;
  final List<DartParameter> parameters;

  DartMethod({
    required String name,
    required ElementLocation location,
    required DartElement parent,
    required this.returnType,
    required this.parameters,
    this.kind = MethodKind.REGULAR,
    this.isAbstract = false,
    this.isStatic = false,
  }) : super(name: name, location: location, parent: parent);

  @override
  List<Object?> get props =>
      super.props + [isAbstract, isStatic, returnType, kind, parameters];
}

class DartConstructor extends DartMethod {
  final ConstructorKind constructorKind;

  DartConstructor({
    required String name,
    required ElementLocation location,
    required DartElement parent,
    required DartType returnType,
    required List<DartParameter> parameters,
    required this.constructorKind,
  }) : super(
          name: name,
          location: location,
          parent: parent,
          returnType: returnType,
          parameters: parameters,
          kind: MethodKind.CONSTRUCTOR,
          isAbstract: false,
          isStatic: false,
        );

  @override
  List<Object?> get props => super.props + [constructorKind];
}
