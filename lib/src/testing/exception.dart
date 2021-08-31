import 'package:arch_test/arch_test.dart';

class ViolationsException {
  final List<String> violations;
  final DartPackage package;

  ViolationsException({required this.violations, required this.package});

  @override
  String toString() {
    final violationsStr = violations.map((v) => '- $v').join(';\r\n');
    return 'Found the following violations on package "${package.name}": \r\n$violationsStr';
  }
}
