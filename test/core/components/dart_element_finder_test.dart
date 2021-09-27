import 'package:arch_test/core/components/dart_element_finder.dart';
import 'package:arch_test/core/core.dart';
import 'package:arch_test/core/exception.dart';
import 'package:test/test.dart';

void main() {
  late DartElementFinder finder;

  setUp(() {
    finder = DartElementFinder();
  });

  test('Should find class by ref', () {
    final ref = DartElementRef<DartClass>(
      name: 'SomeClass',
      location: ElementLocation(
        uri: 'package:pkg/some_class.dart',
        column: 1,
        line: 5,
      ),
    );

    final dartClass = finder.findByRef<DartClass>(ref, source: mockPackage);

    expect(dartClass, isA<DartClass>());
  });

  test('Should return all elements', () {
    final elements = finder.findByMatcher(
      matcher: (_) => true,
      source: mockPackage,
    );
    expect(elements.length, 4);
  });

  test('Should return elements of given type', () {
    final dartClasses = finder.findByType<DartClass>(source: mockPackage);
    expect(dartClasses.length, 1);

    final dartMethods = finder.findByType<DartMethod>(source: mockPackage);
    expect(dartMethods.length, 2);
  });

  test('Should return null if element does not exist', () {
    final ref = DartElementRef<DartClass>(
      name: 'NonexistingClass',
      location: ElementLocation(
        uri: 'package:pkg/non_existing_class.dart',
        column: 1,
        line: 1,
      ),
    );

    final dartClass = finder.findByRef<DartClass>(ref, source: mockPackage);

    expect(dartClass, isNull);
  });

  test(
      'Should throw exception if multiple elements are found on findOneByMatcher',
      () async {
    expect(
      () => finder.findOneByMatcher(matcher: (_) => true, source: mockPackage),
      throwsA(isA<MultipleElementsFoundException>()),
    );
  });
}

final mockPackage = DartPackage(
  name: 'pkg',
  libraries: [
    DartLibrary(
      name: 'some_class.dart',
      location: ElementLocation(
        uri: 'package:pkg/some_class.dart',
        column: 1,
        line: 1,
      ),
      classes: [
        DartClass(
          name: 'SomeClass',
          location: ElementLocation(
            uri: 'package:pkg/some_class.dart',
            column: 1,
            line: 5,
          ),
          parentRef: DartElementRef<DartLibrary>(
            name: 'package:pkg/some_class.dart',
            location: ElementLocation(
              uri: 'package:pkg/some_class.dart',
              column: 1,
              line: 1,
            ),
          ),
          methods: [
            DartMethod(
              name: 'doNothing',
              location: ElementLocation(
                uri: 'package:pkg/some_class.dart',
                column: 3,
                line: 2,
              ),
              parentRef: DartElementRef<DartClass>(
                name: 'package:pkg/some_class.dart',
                location: ElementLocation(
                  uri: 'package:pkg/some_class.dart',
                  column: 1,
                  line: 5,
                ),
              ),
              returnType: DartType.voidType(),
            ),
          ],
        ),
      ],
      methods: [
        DartMethod(
          name: 'main',
          location: ElementLocation(
            uri: 'package:pkg/some_class.dart',
            column: 1,
            line: 5,
          ),
          parentRef: DartElementRef<DartLibrary>(
            name: 'package:pkg/some_class.dart',
            location: ElementLocation(
              uri: 'package:pkg/some_class.dart',
              column: 1,
              line: 1,
            ),
          ),
          returnType: DartType.voidType(),
        ),
      ],
    ),
  ],
);
