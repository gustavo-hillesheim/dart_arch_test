import 'package:arch_test/arch_test.dart';
import 'package:test/test.dart';
import 'package:path/path.dart';
import 'package:testing_with_core/main.dart';
import 'package:collection/collection.dart';
import 'package:testing_with_core/repository/base_repository.dart';

void main() {
  late DartPackage package;

  setUp(() {
    package = createPackageLoader().loadPackage('testing_with_core');
  });

  DartLibrary? getLibrary(String libraryName) {
    return package.libraries.firstWhere((lib) => lib.name == libraryName);
  }

  List<DartClass> getClassesInFolder(String folder) {
    return package.libraries
        .where((lib) => lib.name.split(separator).contains(folder))
        .map((lib) => lib.classes)
        .fold<List<DartClass>>([], (value, element) => [...value, ...element])
        .where((cls) => !cls.isEnum)
        .toList();
  }

  bool isSameType(DartType one, DartType other, {bool ignoreGenerics = false}) {
    final equals = DeepCollectionEquality();
    final myProps = [
      one.name,
      one.location,
      ignoreGenerics ? null : one.generics
    ];
    final otherProps = [
      other.name,
      other.location,
      ignoreGenerics ? null : other.generics
    ];
    return equals.equals(myProps, otherProps);
  }

  bool checkImports(DartLibrary library,
      {required List<String> allowedFolders}) {
    final allowedDependencies = library.dependencies
        .where((dep) =>
            allowedFolders.any((folder) => dep.library.startsWith(folder)) ||
            dep.package != 'testing_with_core')
        .toList();
    return library.dependencies.length == allowedDependencies.length;
  }

  test('Name of classes on "entity" folder should end with "Entity"', () {
    final classes = getClassesInFolder('entity');

    final classesEndingInEntity =
        classes.where((cls) => cls.name.endsWith('Entity')).toList();

    expect(
      classes.length,
      classesEndingInEntity.length,
      reason:
          'The name of all classes inside "entity" folder should end with "Entity"',
    );
  });

  test(
      'Entity libraries can not import libraries from outside of the "entity" folder, except from other packages',
      () {
    final classes = getClassesInFolder('entity');

    for (final cls in classes) {
      final folderBasename = dirname(cls.location.library);
      final library = getLibrary(cls.location.library)!;

      final allowedDependencies = library.dependencies
          .where((dep) =>
              dep.library.startsWith(folderBasename) ||
              dep.package != 'testing_with_core')
          .toList();

      expect(
        library.dependencies.length,
        allowedDependencies.length,
        reason:
            'All dependencies in an Entity file should be from outside the package or from inside the "entity" folder',
      );
    }
  });

  test('Name of classes on "repository" folder should end with "Repository"',
      () {
    final classes = getClassesInFolder('repository');

    final classesEndingInRepository =
        classes.where((cls) => cls.name.endsWith('Repository')).toList();

    expect(
      classes.length,
      classesEndingInRepository.length,
      reason:
          'The name of all classes inside "repository" folder should end with "Repository"',
    );
  });

  test(
      'Repository libraries can only import libraries from the "repository" or "entity" folder or from other packages',
      () {
    final classes = getClassesInFolder('repository');

    for (final cls in classes) {
      expect(
        checkImports(
          getLibrary(cls.location.library)!,
          allowedFolders: ['repository', 'entity'],
        ),
        true,
        reason:
            'All dependencies in an Repository file should be from outside the package or from inside the "repository" or "entity" folder',
      );
    }
  });

  test('Repository classes should extends from BaseRepository', () {
    final classes = getClassesInFolder('repository');
    final baseRepositoryType = DartType.from(BaseRepository);

    for (final cls in classes) {
      if (isSameType(cls, baseRepositoryType)) {
        continue;
      }
      expect(
          cls.superClass != null &&
              isSameType(
                cls.superClass!,
                baseRepositoryType,
                ignoreGenerics: true,
              ),
          true);
    }
  });

  test('Name of classes in "service" folder should end in "Service"', () {
    final classes = getClassesInFolder('service');

    final classesEndingInService =
        classes.where((cls) => cls.name.endsWith('Service')).toList();

    expect(
      classes.length,
      classesEndingInService.length,
      reason:
          'The name of all classes inside "service" folder should end with "Service"',
    );
  });

  test(
      'Service libraries can only import libraries from "service", "repository" or "entity" folder or from other packages',
      () {
    final classes = getClassesInFolder('service');

    for (final cls in classes) {
      expect(
        checkImports(
          getLibrary(cls.location.library)!,
          allowedFolders: ['service', 'repository', 'entity'],
        ),
        true,
        reason:
            'All dependencies in an Service file should be from outside the package or from inside "service", "repository" or "entity" folder',
      );
    }
  });

  test('Name of classes in "controller" folder should end in "Controller"', () {
    final classes = getClassesInFolder('controller');

    final classesEndingInController =
        classes.where((cls) => cls.name.endsWith('Controller')).toList();

    expect(
      classes.length,
      classesEndingInController.length,
      reason:
          'The name of all classes inside "controller" folder should end with "Controller"',
    );
  });
}
