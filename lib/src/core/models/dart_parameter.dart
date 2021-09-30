import 'models.dart';

/// Location for parameters is always unknown
class DartParameter extends DartElement {
  final DartType type;
  final bool hasDefaultValue;
  final bool isConst;
  final bool isFinal;
  final ParameterKind kind;
  final List<DartMetadata> metadata;
  @override
  final DartElementRef<DartMethod>? parentRef;

  DartParameter({
    required String name,
    required this.type,
    this.parentRef,
    this.metadata = const [],
    this.hasDefaultValue = false,
    this.isConst = false,
    this.isFinal = false,
    this.kind = ParameterKind.REGULAR,
  }) : super(name: name, location: ElementLocation.unknown());

  @override
  List<Object?> get props =>
      super.props + [type, hasDefaultValue, isConst, isFinal, kind, metadata];
}
