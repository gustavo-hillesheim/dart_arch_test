import 'package:arch_test/src/models/arch_rule.dart';

class ArchTestDeclarator {
  ArchTestDeclarator._();

  static final ArchTestDeclarator instance = ArchTestDeclarator._();

  final _rules = <ArchRule>[];

  void addTestFor(ArchRule rule) {
    _rules.add(rule);
  }
}
