import 'models.dart';

class DartMethod extends DartDeclaration {
  final bool isAbstract;
  final bool isStatic;
  final DartType returnType;
  final MethodKind kind;
  final List<DartParameter<DartMethod>> parameters;
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

  @override
  String toString() {
    return 'DartMethod(name: $name, location: $location, returnType: $returnType, parameters: $parameters, kind: $kind, isAbstract: $isAbstract, isStatic: $isStatic, isTopLevel: $isTopLevel, metadata: $metadata, parentRef: $parentRef)';
  }
}
