import 'package:arch_test/arch_test.dart';
import 'package:testing_with_testing/main.dart';
import 'package:testing_with_testing/repository/base_repository.dart';

void main() {
  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.pathMatches('entity'),
    validation: Validations.nameEndsWith('Entity'),
  ));

  archTest(ArchRule<DartLibrary>(
    selector: Selectors.libraries,
    filter: Filters.pathMatches('entity'),
    validation: Validations.onlyHaveDependenciesFromFolders(['entity']),
  ));

  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.pathMatches('repository'),
    validation: Validations.nameEndsWith('Repository'),
  ));

  archTest(ArchRule<DartLibrary>(
    selector: Selectors.libraries,
    filter: Filters.pathMatches('repository'),
    validation: Validations.onlyHaveDependenciesFromFolders(
      ['entity', 'repository'],
    ),
  ));

  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.pathMatches('repository'),
    validation: Validations.extendsClass<BaseRepository>(),
  ));

  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.pathMatches('service'),
    validation: Validations.nameEndsWith('Service'),
  ));

  archTest(ArchRule<DartLibrary>(
    selector: Selectors.libraries,
    filter: Filters.pathMatches('service'),
    validation: Validations.onlyHaveDependenciesFromFolders(
      ['entity', 'repository', 'service'],
    ),
  ));

  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.pathMatches('controller'),
    validation: Validations.nameEndsWith('Controller'),
  ));
}
