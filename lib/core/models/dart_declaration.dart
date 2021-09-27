import 'package:arch_test/arch_test.dart';

abstract class DartDeclaration extends DartElement {
  final bool isTopLevel;

  DartDeclaration({
    bool? isTopLevel,
    required String name,
    required ElementLocation location,
  })  : isTopLevel = isTopLevel ?? false,
        super(
          name: name,
          location: location,
        );

  bool get isPrivate => name.startsWith('_');

  @override
  List<Object?> get props => super.props + [isTopLevel];
}
