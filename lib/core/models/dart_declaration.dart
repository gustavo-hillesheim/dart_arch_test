import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/dart_metadata.dart';

abstract class DartDeclaration extends DartElement {
  final bool isTopLevel;
  final List<DartMetadata> metadata;

  DartDeclaration({
    required String name,
    required ElementLocation location,
    this.isTopLevel = false,
    this.metadata = const [],
  }) : super(
          name: name,
          location: location,
        );

  bool get isPrivate => name.startsWith('_');

  @override
  List<Object?> get props => super.props + [isTopLevel, metadata];
}
