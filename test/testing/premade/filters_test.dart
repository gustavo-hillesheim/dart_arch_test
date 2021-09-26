import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/components/dart_element_finder.dart';
import 'package:arch_test/testing/premade/filters.dart';
import 'package:test/test.dart';

import '../../mock/models.dart';

void main() {
  test('Filters.id should return all elements', () async {
    final package = createSamplePackage();
    final elements =
        DartElementFinder().findByType<DartElement>(source: package);

    expect(elements.where(Filters.id()), elements);
  });

  group('Filters.pathMatches', () {
    test('should return all elements', () {
      expect(elements.where(Filters.pathMatches('values')), [v1, v2, v3]);
    });

    test('should return v1 and v3', () {
      expect(elements.where(Filters.pathMatches('variables')), [v1, v3]);
    });
  });

  group('Filters.nameStartsWith', () {
    test('should return all elements', () {
      expect(elements.where(Filters.nameStartsWith('v')), [v1, v2, v3]);
    });

    test('should return no elements', () {
      expect(elements.where(Filters.nameStartsWith('abc')), []);
    });
  });

  group('Filters.nameEndsWith', () {
    test('should return only v1', () {
      expect(elements.where(Filters.nameEndsWith('1')), [v1]);
    });

    test('should return no elements', () {
      expect(elements.where(Filters.nameEndsWith('123')), []);
    });
  });

  group('Filters.insideFolder', () {
    test('should return only v1', () {
      expect(
          elements
              .where(Filters.insideFolder('variables', includeNested: false)),
          [v1]);
    });
    test('should return v1 and v3', () {
      expect(elements.where(Filters.insideFolder('variables')), [v1, v3]);
    });
    test('should return no elements', () {
      expect(elements.where(Filters.insideFolder('pkg')), []);
    });
  });
}

final v1 = DartVariable(
  name: 'v1',
  location: ElementLocation(
      uri: 'package:pkg/variables/values.dart', column: 1, line: 1),
  parentRef: null,
  type: DartType.from<String>(),
);
final v2 = DartVariable(
  name: 'v2',
  location: ElementLocation(
    uri: 'package:pkg/constants/values.dart',
    column: 1,
    line: 1,
  ),
  parentRef: null,
  type: DartType.from<String>(),
);
final v3 = DartVariable(
  name: 'v3',
  location: ElementLocation(
      uri: 'package:pkg/variables/nested/values.dart', column: 1, line: 1),
  parentRef: null,
  type: DartType.from<String>(),
);
final elements = [v1, v2, v3];
