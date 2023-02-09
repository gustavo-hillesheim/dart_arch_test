import 'package:arch_test/core.dart';
import 'package:arch_test/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final validationOne = Validation<DartElement>(
    (el, __, addViolation) =>
        el.name.contains('Var') ? addViolation('validation One') : null,
    description: 'be validated first',
  );
  final validationTwo = Validation(
    (el, __, addViolation) =>
        el is DartVariable ? addViolation('validation Two') : null,
    description: 'be validated second',
  );
  late FakeAddViolation addViolation;

  setUp(() {
    addViolation = FakeAddViolation();
  });

  test('should find validations when combining with "and" method', () {
    final result = validationOne.and(validationTwo);
    result(
      DartVariable(
        name: 'someVar',
        location: ElementLocation.unknown(),
        type: DartType.from<String>(),
      ),
      DartPackage(name: ''),
      addViolation,
    );

    verify(() => addViolation('validation One'));
    verify(() => addViolation('validation Two'));
    expect(validationOne.and(validationTwo).description,
        'be validated first AND be validated second');
    expect(validationTwo.and(validationOne).description,
        'be validated second AND be validated first');
  });

  test('should not find violations when combining with "or" method', () {
    final result = validationOne.or(validationTwo);
    result(
      DartVariable(
        name: 'someClass',
        location: ElementLocation.unknown(),
        type: DartType.from<String>(),
      ),
      DartPackage(name: ''),
      addViolation,
    );

    verifyNever(() => addViolation(any()));
  });

  test('should find violations when combining with "or" method', () {
    final result = validationOne.or(validationTwo);
    result(
      DartVariable(
        name: 'someVar',
        location: ElementLocation.unknown(),
        type: DartType.from<String>(),
      ),
      DartPackage(name: ''),
      addViolation,
    );

    verify(() => addViolation('validation One'));
    verify(() => addViolation('validation Two'));
  });
}

class FakeAddViolation extends Mock {
  void call(String violation);
}
