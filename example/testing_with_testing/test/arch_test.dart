import 'package:arch_test/arch_test.dart';
import 'package:test/test.dart';
import 'package:testing_with_testing/main.dart';
import 'package:testing_with_testing/repository/base_repository.dart';

void main() {
  late DartPackage package;

  setUp(() {
    package = DartPackageLoader.instance.loadPackage('testing_with_testing');
  });

  archTest(
    'Name of classes on "entity" folder should end with "Entity"',
    'testing_with_testing',
    ArchRule<DartClass>(
      selector: Selectors.classes,
      filter: Filters.pathMatches('entity'),
      validation: Validations.nameEndsWith('Entity'),
    ),
  );

  archTest(
    'Entity libraries can not import libraries from outside of the "entity" folder, except from other packages',
    'testing_with_testing',
    ArchRule<DartLibrary>(
      selector: Selectors.libraries,
      filter: Filters.pathMatches('entity'),
      validation: Validations.onlyHaveDependenciesFromFolders(['entity']),
    ),
  );

  archTest(
    'Name of classes on "repository" folder should end with "Repository"',
    'testing_with_testing',
    ArchRule<DartClass>(
      selector: Selectors.classes,
      filter: Filters.pathMatches('repository'),
      validation: Validations.nameEndsWith('Repository'),
    ),
  );

  archTest(
    'Repository libraries can only import libraries from the "repository" or "entity" folder or from other packages',
    'testing_with_testing',
    ArchRule<DartLibrary>(
      selector: Selectors.libraries,
      filter: Filters.pathMatches('repository'),
      validation: Validations.onlyHaveDependenciesFromFolders(
        ['entity', 'repository'],
      ),
    ),
  );

  archTest(
    'Repository classes should extends from BaseRepository',
    'testing_with_testing',
    ArchRule<DartClass>(
      selector: Selectors.classes,
      filter: Filters.pathMatches('repository'),
      validation: Validations.extendsClass<BaseRepository>(),
    ),
  );

  archTest(
    'Name of classes in "service" folder should end in "Service"',
    'testing_with_testing',
    ArchRule<DartClass>(
      selector: Selectors.classes,
      filter: Filters.pathMatches('service'),
      validation: Validations.nameEndsWith('Service'),
    ),
  );

  archTest(
    'Service libraries can only import libraries from "service", "repository" or "entity" folder or from other packages',
    'testing_with_testing',
    ArchRule<DartLibrary>(
      selector: Selectors.libraries,
      filter: Filters.pathMatches('service'),
      validation: Validations.onlyHaveDependenciesFromFolders(
        ['entity', 'repository', 'service'],
      ),
    ),
  );

  archTest(
    'Name of classes in "controller" folder should end in "Controller"',
    'testing_with_testing',
    ArchRule<DartClass>(
      selector: Selectors.classes,
      filter: Filters.pathMatches('controller'),
      validation: Validations.nameEndsWith('Controller'),
    ),
  );
}
