import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/mappers/class_mirror_mapper.dart';
import 'package:arch_test/testing/premade/validations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late AddViolationMock addViolationMock;
  late ClassMirrorMapper classMirrorMapper;

  setUp(() {
    addViolationMock = AddViolationMock();
    classMirrorMapper = ClassMirrorMapper.instance;
  });

  group('Validations.nameEndsWith', () {
    test('should add violation', () {
      final condition = Validations.nameEndsWith('Repository');
      condition(
        FakeDartElement(name: 'NotARepositoryClass'),
        FakeDartPackage(),
        addViolationMock,
      );

      verify(
          () => addViolationMock('Should have name ending with "Repository"'));
    });

    test('should not add violation', () {
      final condition = Validations.nameEndsWith('UseCase');
      condition(
        FakeDartElement(name: 'GetUserUseCase'),
        FakeDartPackage(),
        addViolationMock,
      );

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.nameStartsWith', () {
    test('should add violation', () {
      final condition = Validations.nameStartsWith('Abstract');
      condition(
        FakeDartElement(name: 'NotAbstract'),
        FakeDartPackage(),
        addViolationMock,
      );

      verify(
          () => addViolationMock('Should have name starting with "Abstract"'));
    });

    test('should not add violation', () {
      final condition = Validations.nameStartsWith('Abstract');
      condition(
        FakeDartElement(name: 'AbstractRepository'),
        FakeDartPackage(),
        addViolationMock,
      );

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.noDependencyMatches', () {
    test('should add violation', () {
      final condition = Validations.noDependencyMatches('forbidden_folder');
      final library = FakeDartLibrary(
        name: 'path/to/lib.dart',
        importedLibraries: [
          'package:some_package/forbidden_folder/components.dart'
        ],
      );

      condition(library, FakeDartPackage(), addViolationMock);

      verify(
        () => addViolationMock(
          'No dependency can match the regex "forbidden_folder".\n'
          'Invalid imports:\n'
          '- package:some_package/forbidden_folder/components.dart',
        ),
      );
    });

    test('should add violation with description', () {
      final condition = Validations.noDependencyMatches(
        'forbidden_folder',
        description: 'Should not import from "forbidden_folder"',
      );
      final library = FakeDartLibrary(
        name: 'path/to/lib.dart',
        importedLibraries: [
          'package:some_package/forbidden_folder/components.dart'
        ],
      );

      condition(library, FakeDartPackage(), addViolationMock);

      verify(
        () => addViolationMock(
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

      condition(library, FakeDartPackage(), addViolationMock);

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.onlyHaveDependenciesFromFolders', () {
    test('Should add violation', () {
      final condition =
          Validations.onlyHaveDependenciesFromFolders(['allowed_folder']);
      final library = FakeDartLibrary(
        name: 'path/to/lib.dart',
        importedLibraries: [
          'package:some_package/forbidden_folder/components.dart'
        ],
      );

      condition(
          library, FakeDartPackage(name: 'some_package'), addViolationMock);

      verify(
        () => addViolationMock(
          'Can only have dependencies from folders [allowed_folder].\n'
          'Invalid imports:\n'
          '- package:some_package/forbidden_folder/components.dart',
        ),
      );
    });
    test('Should not add violation', () {
      final condition =
          Validations.onlyHaveDependenciesFromFolders(['allowed_folder']);
      final library = FakeDartLibrary(
        name: 'path/to/lib.dart',
        importedLibraries: [
          'package:some_package/allowed_folder/components.dart'
        ],
      );

      condition(
          library, FakeDartPackage(name: 'some_package'), addViolationMock);

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.extendsClass', () {
    test('should add violation', () {
      Validations.extendsClass<AbstractRepository>()(
        classMirrorMapper.toDartClass(reflectClass(NonRepository)),
        FakeDartPackage(),
        addViolationMock,
      );

      verify(() => addViolationMock(
            'Should extend AbstractRepository<dynamic>',
          ));
    });

    test('should add violation for non specific repository', () {
      Validations.extendsClass<AbstractRepository<String>>()(
        classMirrorMapper.toDartClass(reflectClass(UserRepository)),
        FakeDartPackage(),
        addViolationMock,
      );

      verify(() => addViolationMock(
            'Should extend AbstractRepository<String>',
          ));
    });

    test('should not add violation for non specific repository', () {
      Validations.extendsClass<AbstractRepository>()(
        classMirrorMapper.toDartClass(reflectClass(UserRepository)),
        FakeDartPackage(),
        addViolationMock,
      );

      verifyNever(() => addViolationMock(any()));
    });

    test('should not add violation for specific repository', () {
      Validations.extendsClass<AbstractRepository<String>>()(
        classMirrorMapper.toDartClass(reflectClass(SpecificRepository)),
        FakeDartPackage(),
        addViolationMock,
      );

      verifyNever(() => addViolationMock(any()));
    });
  });

  group('Validations.implementsClass', () {
    test('should add violation', () {
      Validations.implementsClass<UseCase>()(
        classMirrorMapper.toDartClass(reflectClass(NonUseCase)),
        FakeDartPackage(),
        addViolationMock,
      );

      verify(() => addViolationMock('Should implement UseCase'));
    });

    test('should not add violation', () {
      Validations.implementsClass<UseCase>()(
        classMirrorMapper.toDartClass(reflectClass(UserUseCase)),
        FakeDartPackage(),
        addViolationMock,
      );

      verifyNever(() => addViolationMock(any()));
    });
  });
}

class UseCase {}

class UserUseCase implements UseCase {}

class NonUseCase {}

class AbstractRepository<T> {}

class UserRepository extends AbstractRepository {}

class SpecificRepository extends AbstractRepository<String> {}

class NonRepository {}

class FakeDartPackage extends DartPackage {
  FakeDartPackage({String? name})
      : super(
          name: name ?? '',
          libraries: [],
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
