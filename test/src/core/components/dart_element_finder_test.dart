import 'package:arch_test/src/core/components/dart_element_finder.dart';
import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/testing/exception.dart';
import 'package:test/test.dart';

void main() {
  late DartElementFinder finder;

  setUp(() {
    finder = DartElementFinder();
  });

  test('Should find class by ref', () async {
    final ref = DartElementRef(
      elementType: DartClass,
      name: 'SomeClass',
      location: ElementLocation(
        uri: 'package:pkg/some_class.dart',
        column: 1,
        line: 1,
      ),
    );

    final dartClass = finder.findByRef<DartClass>(ref, source: mockPackage);

    expect(dartClass, isA<DartClass>());
  });

  test('Should return elements of given type', () async {
    final dartClasses =
        finder.findByType<DartClass>(type: DartClass, source: mockPackage);
    expect(dartClasses.length, 1);

    final dartMethods =
        finder.findByType<DartMethod>(type: DartMethod, source: mockPackage);
    expect(dartMethods.length, 2);
  });

  test('Should return null if element does not exist', () async {
    final ref = DartElementRef(
      elementType: DartClass,
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

final mockPackage = DartPackage(name: 'pkg', libraries: [
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
          line: 1,
        ),
        superInterfaces: [],
        generics: [],
        fields: [],
        methods: [
          DartMethod(
            name: 'doNothing',
            location: ElementLocation(
              uri: 'package:pkg/some_class.dart',
              column: 3,
              line: 2,
            ),
            returnType: DartType.voidType(),
            parameters: [],
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
        returnType: DartType.voidType(),
        parameters: [],
      ),
    ],
    dependencies: [],
  ),
]);
