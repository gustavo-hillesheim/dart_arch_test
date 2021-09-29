import 'package:arch_test/core.dart';
import 'package:arch_test/testing.dart';
import 'package:test/test.dart';

void main() {
  final elements = [
    DartVariable(
      name: 'myVarFiltered',
      location: ElementLocation.unknown(),
      type: DartType.from<String>(),
    ),
    DartVariable(
      name: 'nonFilteredVar',
      location: ElementLocation.unknown(),
      type: DartType.from<String>(),
    ),
    DartVariable(
      name: '_anotherNonFilteredVar',
      location: ElementLocation.unknown(),
      type: DartType.from<String>(),
    ),
  ];
  final nameFilter = Filter<DartElement>(
    (el) => el.name.endsWith('Filtered'),
    description: 'have name ending with "Filtered"',
  );
  final publicFilter = Filter<DartElement>(
    (el) => !el.name.startsWith('_'),
    description: 'have name starting with "_"',
  );

  test('Should combine filters on "and" method', () {
    expect(
      nameFilter.and(publicFilter).description,
      'have name ending with "Filtered" AND have name starting with "_"',
    );
    expect(
      publicFilter.and(nameFilter).description,
      'have name starting with "_" AND have name ending with "Filtered"',
    );
    expect(elements.where(nameFilter.and(publicFilter)), [
      DartVariable(
        name: 'myVarFiltered',
        location: ElementLocation.unknown(),
        type: DartType.from<String>(),
      ),
    ]);
  });

  test('Should combine filters on "or" method', () {
    expect(
      nameFilter.or(publicFilter).description,
      'have name ending with "Filtered" OR have name starting with "_"',
    );
    expect(
      publicFilter.or(nameFilter).description,
      'have name starting with "_" OR have name ending with "Filtered"',
    );
    expect(elements.where(nameFilter.or(publicFilter)), [
      DartVariable(
        name: 'myVarFiltered',
        location: ElementLocation.unknown(),
        type: DartType.from<String>(),
      ),
      DartVariable(
        name: 'nonFilteredVar',
        location: ElementLocation.unknown(),
        type: DartType.from<String>(),
      ),
    ]);
  });
}
