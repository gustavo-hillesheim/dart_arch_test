import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/dart_declaration.dart';
import 'package:arch_test/core/models/dart_metadata.dart';
import 'package:arch_test/core/models/dart_type.dart';
import 'package:arch_test/core/models/element_location.dart';

/// Representation of a Dart variable.
/// Can be fields of a class, parameters or top level variables.
class DartVariable extends DartDeclaration {
  final bool isFinal;
  final bool isConst;
  final bool isStatic;
  final DartType type;
  @override
  final DartElementRef? parentRef;

  DartVariable({
    required String name,
    required ElementLocation location,
    required this.type,
    this.parentRef,
    this.isFinal = false,
    this.isConst = false,
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
  List<Object?> get props => super.props + [isFinal, isConst, isStatic, type];
}
