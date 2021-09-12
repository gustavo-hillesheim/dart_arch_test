import 'package:arch_test/src/core/models/dart_element.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/element_location.dart';

/// Representation of a Dart variable.
/// Can be fields of a class, parameters or top level variables.
class DartVariable extends DartElement {
  final bool isFinal;
  final bool isConst;
  final bool isPrivate;
  final bool isStatic;
  final DartType type;

  DartVariable({
    required String name,
    required ElementLocation location,
    required DartElement parent,
    required this.type,
    this.isFinal = false,
    this.isConst = false,
    this.isPrivate = false,
    this.isStatic = false,
  }) : super(name: name, location: location, parent: parent);

  @override
  List<Object?> get props =>
      super.props + [isFinal, isConst, isPrivate, isStatic, type];
}
