import 'models.dart';

/// Location for parameters is always unknown
class DartParameter<T extends DartElement> extends DartElement {
  final DartType type;
  final bool hasDefaultValue;
  final bool isConst;
  final bool isFinal;
  final ParameterKind kind;
  final List<DartMetadata> metadata;
  @override
  final DartElementRef<T>? parentRef;

  DartParameter({
    required String name,
    required this.type,
    this.parentRef,
    this.metadata = const [],
    this.hasDefaultValue = false,
    this.isConst = false,
    this.isFinal = false,
    this.kind = ParameterKind.REGULAR,
    required ElementLocation location,
  }) : super(name: name, location: location);

  @override
  List<Object?> get props =>
      super.props + [type, hasDefaultValue, isConst, isFinal, kind, metadata];

  @override
  String toString() {
    return 'DartParameter<$T>(name: "$name", location: $location, type: $type, kind: $kind, hasDefaultValue: $hasDefaultValue, isConst: $isConst, isFinal: $isFinal, parentRef: $parentRef)';
  }
}
