import 'package:arch_test/src/core/models/arch_test.dart';

class ArchTestDeclarator {
  ArchTestDeclarator._();

  static final ArchTestDeclarator instance = ArchTestDeclarator._();

  final _tests = <ArchTest>[];

  List<ArchTest> get declaredTests => List.unmodifiable(_tests);

  void add(ArchTest test) {
    _tests.add(test);
  }
}
