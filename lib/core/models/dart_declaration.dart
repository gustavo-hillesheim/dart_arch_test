import 'package:arch_test/arch_test.dart';

abstract class DartDeclaration extends DartElement {
  final bool isTopLevel;

  DartDeclaration({
    this.isTopLevel = false,
    required String name,
    required ElementLocation location,
  }) : super(
          name: name,
          location: location,
        );

  bool get isPrivate => name.startsWith('_');

  @override
  List<Object?> get props => super.props + [isTopLevel];
}
