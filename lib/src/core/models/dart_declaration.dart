import 'models.dart';

abstract class DartDeclaration extends DartElement {
  final bool isTopLevel;
  final List<DartMetadata> metadata;

  const DartDeclaration({
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
