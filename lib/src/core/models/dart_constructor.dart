import 'package:arch_test/arch_test.dart';

class DartConstructor extends DartDeclaration {
  final ConstructorKind constructorKind;
  final DartType returnType;
  final List<DartParameter<DartConstructor>> parameters;
  @override
  final DartElementRef? parentRef;

  DartConstructor({
    required String name,
    required ElementLocation location,
    required this.returnType,
    required this.constructorKind,
    this.parameters = const [],
    this.parentRef,
    List<DartMetadata> metadata = const [],
  }) : super(
          name: name,
          location: location,
          isTopLevel: false,
          metadata: metadata,
        );

  @override
  List<Object?> get props =>
      super.props + [constructorKind, returnType, parameters];

  @override
  String toString() {
    return 'DartConstructor(name: "$name", location: $location, returnType: $returnType, constructorKind: $constructorKind, parameters: $parameters, metadata: $metadata, isTopLevel: $isTopLevel, parentRef: $parentRef)';
  }
}
