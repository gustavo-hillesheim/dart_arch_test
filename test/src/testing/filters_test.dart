import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/components/dart_element_finder.dart';
import 'package:arch_test/src/testing/filters.dart';
import 'package:test/test.dart';

import '../../mock/models.dart';

void main() {
  test('Filters.id should return all elements', () async {
    final package = createSamplePackage();
    final elements =
        DartElementFinder().findByType<DartElement>(source: package);

    expect(Filters.id(elements), elements);
  });

  group('Filters.pathMatches', () {
    test('should return all elements', () {
      expect(Filters.pathMatches('values')(elements), [v1, v2]);
    });

    test('should return only v1', () {
      expect(Filters.pathMatches('variables')(elements), [v1]);
    });
  });

  group('Filters.nameStartsWith', () {
    test('should return all elements', () {
      expect(Filters.nameStartsWith('v')(elements), [v1, v2]);
    });

    test('should return no elements', () {
      expect(Filters.nameStartsWith('abc')(elements), []);
    });
  });

  group('Filters.nameEndsWith', () {
    test('should return only v1', () {
      expect(Filters.nameEndsWith('1')(elements), [v1]);
    });

    test('should return no elements', () {
      expect(Filters.nameEndsWith('123')(elements), []);
    });
  });
}

final v1 = DartVariable(
  name: 'v1',
  location: ElementLocation(
      uri: 'package:pkg/variables/values.dart', column: 1, line: 1),
  parentRef: null,
  type: DartType.from(String),
);
final v2 = DartVariable(
  name: 'v2',
  location: ElementLocation(
    uri: 'package:pkg/constants/values.dart',
    column: 1,
    line: 1,
  ),
  parentRef: null,
  type: DartType.from(String),
);
final elements = [v1, v2];
