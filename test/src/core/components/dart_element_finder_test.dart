import 'package:arch_test/src/core/components/dart_element_finder.dart';
import 'package:arch_test/src/core/core.dart';
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

    final dartClasses = finder.findByRef<DartClass>(ref, source: mockPackage);

    expect(dartClasses.length, 1);
    expect(dartClasses.elementAt(0), isA<DartClass>());
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
        methods: [],
      ),
    ],
    methods: [],
    dependencies: [],
  ),
]);
