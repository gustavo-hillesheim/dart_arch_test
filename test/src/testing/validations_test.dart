import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/testing/validations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late AddViolationMock addViolationMock;

  setUp(() {
    addViolationMock = AddViolationMock();
  });

  group('Validations.nameEndsWith', () {
    test('should add violation', () {
      final condition = Validations.nameEndsWith('Repository');
      condition(FakeDartElement(name: 'NotARepositoryClass'), addViolationMock);

      verify(() => addViolationMock(
          'Name of NotARepositoryClass should end with "Repository"'));
    });

    test('should not add violation', () {
      final condition = Validations.nameEndsWith('UseCase');
      condition(FakeDartElement(name: 'GetUserUseCase'), addViolationMock);

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.nameStartsWith', () {
    test('should add violation', () {
      final condition = Validations.nameStartsWith('Abstract');
      condition(FakeDartElement(name: 'NotAbstract'), addViolationMock);

      verify(() =>
          addViolationMock('Name of NotAbstract should start with "Abstract"'));
    });

    test('should not add violation', () {
      final condition = Validations.nameStartsWith('Abstract');
      condition(FakeDartElement(name: 'AbstractRepository'), addViolationMock);

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.noImportMatches', () {
    test('should add violation', () {
      final condition = Validations.noDependencyMatches('forbidden_folder');
      final library = FakeDartLibrary(
        name: 'path/to/lib.dart',
        importedLibraries: [
          'package:some_package/forbidden_folder/components.dart'
        ],
      );

      condition(library, addViolationMock);

      verify(
        () => addViolationMock(
          'Errors in library path/to/lib.dart.\n'
          'Invalid imports:\n'
          '- package:some_package/forbidden_folder/components.dart',
        ),
      );
    });

    test('should add violation with additional message', () {
      final condition = Validations.noDependencyMatches(
        'forbidden_folder',
        message: 'Should not import from "forbidden_folder"',
      );
      final library = FakeDartLibrary(
        name: 'path/to/lib.dart',
        importedLibraries: [
          'package:some_package/forbidden_folder/components.dart'
        ],
      );

      condition(library, addViolationMock);

      verify(
        () => addViolationMock(
          'Errors in library path/to/lib.dart.\n'
          'Should not import from "forbidden_folder".\n'
          'Invalid imports:\n'
          '- package:some_package/forbidden_folder/components.dart',
        ),
      );
    });

    test('should not add violation', () {
      final condition = Validations.noDependencyMatches('controller');
      final library = FakeDartLibrary(importedLibraries: [
        'package:my_package/models/user_model.dart',
      ]);

      condition(library, addViolationMock);

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.extendsClass', () {
    test('should add violation', () {
      final condition = Validations.extendsClass(
        FakeDartClass(name: 'NonExistentType'),
      );

      condition(FakeDartClass(name: 'SomeClass'), addViolationMock);

      verify(() => addViolationMock('SomeClass should extend NonExistentType'));
    });

    test('should not add violation', () {
      final condition = Validations.extendsClass(
        FakeDartClass(name: 'AbstractRepository'),
      );

      condition(
        FakeDartClass(superClass: FakeDartClass(name: 'AbstractRepository')),
        addViolationMock,
      );

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.implementsClass', () {
    test('should add violation', () {
      final condition = Validations.implementsClass(
        FakeDartClass(name: 'SomeInterface'),
      );

      condition(FakeDartClass(name: 'ErroredClass'), addViolationMock);

      verify(() =>
          addViolationMock('ErroredClass should implement SomeInterface'));
    });

    test('should not add violation', () {
      final condition = Validations.implementsClass(
        FakeDartClass(name: 'UseCase'),
      );

      condition(
        FakeDartClass(superInterfaces: [FakeDartClass(name: 'UseCase')]),
        addViolationMock,
      );

      verifyNever(() => addViolationMock(any()));
    });
  });
}

class FakeDartClass extends DartClass {
  FakeDartClass({
    DartClass? superClass,
    List<DartClass>? superInterfaces,
    String? name,
  }) : super(
          name: name ?? '',
          fields: [],
          methods: [],
          superClass: superClass,
          superInterfaces: superInterfaces ?? [],
          generics: [],
          location: ElementLocation(uri: '', column: 1, line: 1),
          parentRef: null,
        );
}

class FakeDartLibrary extends DartLibrary {
  FakeDartLibrary({String? name, required List<String> importedLibraries})
      : super(
          dependencies: importedLibraries
              .map(
                (lib) => DartLibraryDependency(
                  path: lib,
                  location: ElementLocation(uri: '', column: 1, line: 1),
                  parentRef: null,
                  kind: LibraryDependencyKind.IMPORT,
                ),
              )
              .toList(),
          name: name ?? '',
          location: ElementLocation(uri: '', column: 1, line: 1),
          parentRef: null,
          methods: [],
          classes: [],
        );
}

class FakeDartElement extends DartElement {
  @override
  final DartElementRef<DartElement>? parentRef;

  FakeDartElement({required String name})
      : parentRef = null,
        super(
          name: name,
          location: ElementLocation(uri: '', column: 1, line: 1),
        );
}

class AddViolationMock extends Mock {
  void call(String violation);
}
