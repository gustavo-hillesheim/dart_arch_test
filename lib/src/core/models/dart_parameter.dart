import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_element.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/element_location.dart';
import 'package:arch_test/src/core/models/enums/parameter_kind.dart';

/// Location for parameters is always unknown
class DartParameter extends DartElement {
  final DartType type;
  final bool hasDefaultValue;
  final bool isConst;
  final bool isFinal;
  final ParameterKind kind;

  DartParameter({
    required String name,
    required ElementLocation location,
    required this.type,
    this.hasDefaultValue = false,
    this.isConst = false,
    this.isFinal = false,
    this.kind = ParameterKind.REGULAR,
  }) : super(name: name, location: location);

  @override
  List<Object?> get props =>
      super.props + [type, hasDefaultValue, isConst, isFinal, kind];
}
