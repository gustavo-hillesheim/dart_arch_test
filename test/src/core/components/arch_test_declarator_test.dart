import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/core.dart';
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
        rule: ElementPredicateToArchRuleAdapter(haveNameEndingWith('')),
      );

      declarator.add(test);

      expect(declarator.declaredTests, [test]);
    });
  });
}
