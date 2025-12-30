import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/predicates/predicate_builders.dart';
import 'package:test/test.dart';

void main() {
  late ArchTestDeclarator declarator;

  group('ArchTestDeclarator', () {
    setUp(() {
      declarator = ArchTestDeclarator.forTests();
    });

    test('SHOULD add test to declared tests', () {
      final test = ArchTest(
        selector: classes,
        rule: ElementPredicateToArchRuleAdapter(have(name(), endingWith(''))),
      );

      declarator.add(test);

      expect(declarator.declaredTests, [test]);
    });
  });
}
