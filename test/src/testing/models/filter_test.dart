import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/testing/models/filter.dart';
import 'package:test/test.dart';

void main() {
  final elements = [
    DartVariable(
      name: 'myVarFiltered',
      location: ElementLocation.unknown(),
      parentRef: null,
      type: DartType.from<String>(),
    ),
    DartVariable(
      name: 'nonFilteredVar',
      location: ElementLocation.unknown(),
      parentRef: null,
      type: DartType.from<String>(),
    ),
    DartVariable(
      name: '_anotherNonFilteredVar',
      location: ElementLocation.unknown(),
      parentRef: null,
      type: DartType.from<String>(),
    ),
  ];

  test('Should combine filters on "and" method', () {
    final nameFilter = Filter<DartElement>(
      (el) => el.name.endsWith('Filtered'),
    );
    final publicFilter = Filter<DartElement>(
      (el) => !el.name.startsWith('_'),
    );

    expect(elements.where(nameFilter.and(publicFilter)), [
      DartVariable(
        name: 'myVarFiltered',
        location: ElementLocation.unknown(),
        parentRef: null,
        type: DartType.from<String>(),
      ),
    ]);
  });
}
