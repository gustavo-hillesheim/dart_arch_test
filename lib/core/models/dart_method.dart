import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/dart_declaration.dart';
import 'package:arch_test/core/models/dart_metadata.dart';
import 'package:arch_test/core/models/dart_parameter.dart';
import 'package:arch_test/core/models/dart_type.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:arch_test/core/models/enums/constructor_kind.dart';
import 'package:arch_test/core/models/enums/method_kind.dart';

class DartMethod extends DartDeclaration {
  final bool isAbstract;
  final bool isStatic;
  final DartType returnType;
  final MethodKind kind;
  final List<DartParameter> parameters;
  @override
  final DartElementRef? parentRef;

  DartMethod({
    required String name,
    required ElementLocation location,
    required this.returnType,
    this.parameters = const [],
    this.parentRef,
    this.kind = MethodKind.REGULAR,
    this.isAbstract = false,
    this.isStatic = false,
    bool isTopLevel = false,
    List<DartMetadata> metadata = const [],
  }) : super(
          name: name,
          location: location,
          isTopLevel: isTopLevel,
          metadata: metadata,
        );

  @override
  List<Object?> get props =>
      super.props + [isAbstract, isStatic, returnType, kind, parameters];
}

class DartConstructor extends DartMethod {
  final ConstructorKind constructorKind;

  DartConstructor({
    required String name,
    required ElementLocation location,
    required DartType returnType,
    required this.constructorKind,
    List<DartParameter> parameters = const [],
    DartElementRef? parentRef,
    List<DartMetadata> metadata = const [],
  }) : super(
          name: name,
          location: location,
          returnType: returnType,
          parameters: parameters,
          kind: MethodKind.CONSTRUCTOR,
          isTopLevel: false,
          isAbstract: false,
          isStatic: false,
          parentRef: parentRef,
          metadata: metadata,
        );

  @override
  List<Object?> get props => super.props + [constructorKind];
}
