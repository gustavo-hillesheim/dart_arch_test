import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

final implementCorrespondingInterface = ImplementCorrespondingInterface();

class ImplementCorrespondingInterface extends ArchRule<ClassElement> {
  ImplementCorrespondingInterface();

  @override
  String describe() {
    return 'implement corresponding interface';
  }

  @override
  void check(ClassElement element, ReportViolation reportViolation) {
    final className = element.name;
    final interfaceName = className?.lastIndexOf('Impl') != -1
        ? className!.substring(0, className.lastIndexOf('Impl'))
        : null;

    final implementsInterface = element.interfaces.any((interfaceType) {
      final interfaceElement = interfaceType.element;
      return interfaceElement.name == interfaceName;
    });

    if (!implementsInterface) {
      reportViolation(
        ViolationSeverity.error,
        'Class "$className" does not implement its corresponding interface "$interfaceName".',
      );
    }
  }
}
