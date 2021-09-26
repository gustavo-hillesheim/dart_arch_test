import 'package:arch_test/arch_test.dart';
import 'package:testing_with_fluent/main.dart';
import 'package:testing_with_fluent/repository/base_repository.dart';

void main() {
  archTest(
    classes.that.havePathMatching('entity').should.haveNameEndingWith('Entity'),
  );

  archTest(
    libraries.that
        .havePathMatching('entity')
        .should
        .onlyHaveDependenciesFromFolders(['entity']),
  );

  archTest(
    classes.that
        .havePathMatching('repository')
        .should
        .haveNameEndingWith('Repository')
        .and
        .extendClass<BaseRepository>(),
  );

  archTest(
    libraries.that
        .havePathMatching('repository')
        .should
        .onlyHaveDependenciesFromFolders(['entity', 'repository']),
  );

  archTest(
    classes.that
        .havePathMatching('service')
        .should
        .haveNameEndingWith('Service'),
  );

  archTest(
    libraries.that
        .havePathMatching('service')
        .should
        .onlyHaveDependenciesFromFolders(['entity', 'repository', 'service']),
  );

  archTest(
    classes.that
        .havePathMatching('controller')
        .should
        .haveNameEndingWith('Controller'),
  );
}
