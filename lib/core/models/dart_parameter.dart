import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/dart_element.dart';
import 'package:arch_test/core/models/dart_metadata.dart';
import 'package:arch_test/core/models/dart_type.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:arch_test/core/models/enums/parameter_kind.dart';

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
