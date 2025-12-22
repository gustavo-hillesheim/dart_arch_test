import 'package:arch_test/arch_test.dart';

void main() {
  archTest(
    classes
        .that(resideInDirectory('src/domain/entities'))
        .should(haveNameEndingWith('Entity')),
  );
}
