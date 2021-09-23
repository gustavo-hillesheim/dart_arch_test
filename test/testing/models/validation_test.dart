import 'package:arch_test/arch_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('should combine validations', () {
    final validationOne = Validation(
      (_, __, addViolation) => addViolation('validation One'),
      description: 'be validated first',
    );
    final validationTwo = Validation(
      (_, __, addViolation) => addViolation('validation Two'),
      description: 'be validated second',
    );
    final addViolation = FakeAddViolation();

    final result = validationOne.and(validationTwo);
    result(
      DartVariable(
        name: 'someVar',
        location: ElementLocation.unknown(),
        parentRef: null,
        type: DartType.from<String>(),
      ),
      DartPackage(name: ''),
      addViolation,
    );

    verify(() => addViolation('validation One'));
    verify(() => addViolation('validation Two'));
    expect(result.description, 'be validated first AND be validated second');
  });
}

class FakeAddViolation extends Mock {
  void call(String violation);
}
