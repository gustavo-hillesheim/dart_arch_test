import 'package:arch_test/src/core/models/arch_rule.dart';

class ArchTestDeclarator {
  ArchTestDeclarator._();

  static final ArchTestDeclarator instance = ArchTestDeclarator._();

  final _rules = <ArchRule>[];

  List<ArchRule> get declaredRules => List.unmodifiable(_rules);

  void addTestFor(ArchRule rule) {
    _rules.add(rule);
  }
}
