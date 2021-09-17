import 'package:arch_test/arch_test.dart';
import 'package:test/test.dart';
import 'package:testing_with_testing/main.dart';
import 'package:testing_with_testing/repository/base_repository.dart';

void main() {
  late DartPackage package;

  setUp(() {
    package = createPackageLoader().loadPackage('testing_with_testing');
  });

  test('Name of classes on "entity" folder should end with "Entity"', () {
    ArchTest<DartClass>(
      elementsProvider: ElementsProviders.classes,
      filter: Filters.combine([
        Filters.pathMatches('entity'),
        (el) => !el.isEnum,
      ]),
      validation: Validations.nameEndsWith('Entity'),
    ).validate(package);
  });

  test(
      'Entity libraries can not import libraries from outside of the "entity" folder, except from other packages',
      () {
    ArchTest<DartLibrary>(
      elementsProvider: ElementsProviders.libraries,
      filter: Filters.pathMatches('entity'),
      validation: Validations.noDependencyMatches(
        'package:testing_with_testing\\\\(?!entity)',
      ),
    ).validate(package);
  });

  test('Name of classes on "repository" folder should end with "Repository"',
      () {
    ArchTest<DartClass>(
      elementsProvider: ElementsProviders.classes,
      filter: Filters.combine([
        Filters.pathMatches('repository'),
        (el) => !el.isEnum,
      ]),
      validation: Validations.nameEndsWith('Repository'),
    ).validate(package);
  });

  test(
      'Repository libraries can only import libraries from the "repository" or "entity" folder or from other packages',
      () {
    ArchTest<DartLibrary>(
      elementsProvider: ElementsProviders.libraries,
      filter: Filters.pathMatches('repository'),
      validation: Validations.noDependencyMatches(
        'package:testing_with_testing\\\\(?!(entity)|(repository))',
      ),
    ).validate(package);
  });

  test('Repository classes should extends from BaseRepository', () {
    ArchTest<DartClass>(
      elementsProvider: ElementsProviders.classes,
      filter: Filters.combine([
        Filters.pathMatches('repository'),
        (el) => !el.isEnum,
      ]),
      validation: Validations.nameEndsWith('str'),
    ).validate(package);
  }, skip: 'Disabled until changes in Validations.extendsClass');

  test('Name of classes in "service" folder should end in "Service"', () {
    ArchTest<DartClass>(
      elementsProvider: ElementsProviders.classes,
      filter: Filters.combine([
        Filters.pathMatches('service'),
        (el) => !el.isEnum,
      ]),
      validation: Validations.nameEndsWith('Service'),
    ).validate(package);
  });

  test(
      'Service libraries can only import libraries from "service", "repository" or "entity" folder or from other packages',
      () {
    ArchTest<DartLibrary>(
      elementsProvider: ElementsProviders.libraries,
      filter: Filters.pathMatches('service'),
      validation: Validations.noDependencyMatches(
        'package:testing_with_testing\\\\(?!(entity)|(repository)|(service))',
      ),
    ).validate(package);
  });

  test('Name of classes in "controller" folder should end in "Controller"', () {
    ArchTest<DartClass>(
      elementsProvider: ElementsProviders.classes,
      filter: Filters.combine([
        Filters.pathMatches('controller'),
        (el) => !el.isEnum,
      ]),
      validation: Validations.nameEndsWith('Controller'),
    ).validate(package);
  });
}
