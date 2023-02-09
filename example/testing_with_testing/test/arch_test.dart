import 'package:arch_test/arch_test.dart';
import 'package:testing_with_testing/repository/base_repository.dart';

void main() {
  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.insideFolder('entity'),
    validation: Validations.nameEndsWith('Entity'),
  ));

  archTest(ArchRule<DartLibrary>(
    selector: Selectors.libraries,
    filter: Filters.insideFolder('entity'),
    validation: Validations.onlyHaveDependenciesFromFolders(['entity']),
  ));

  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.insideFolder('repository'),
    validation: Validations.nameEndsWith<DartClass>('Repository')
        .and(Validations.extendsClass<BaseRepository>()),
  ));

  archTest(ArchRule<DartLibrary>(
    selector: Selectors.libraries,
    filter: Filters.insideFolder('repository'),
    validation: Validations.onlyHaveDependenciesFromFolders(
      ['entity', 'repository'],
    ),
  ));

  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.insideFolder('service'),
    validation: Validations.nameEndsWith('Service'),
  ));

  archTest(ArchRule<DartLibrary>(
    selector: Selectors.libraries,
    filter: Filters.insideFolder('service'),
    validation: Validations.onlyHaveDependenciesFromFolders(
      ['entity', 'repository', 'service'],
    ),
  ));

  archTest(ArchRule<DartClass>(
    selector: Selectors.classes,
    filter: Filters.insideFolder('controller'),
    validation: Validations.nameEndsWith('Controller'),
  ));
}
