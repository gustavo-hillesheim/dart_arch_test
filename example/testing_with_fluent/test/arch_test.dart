import 'package:arch_test/arch_test.dart';
import 'package:testing_with_fluent/repository/base_repository.dart';

void main() {
  archTest(
    classes.that.areInsideFolder('entity').should.haveNameEndingWith('Entity'),
  );

  archTest(
    libraries.that
        .areInsideFolder('entity')
        .should
        .onlyHaveDependenciesFromFolders(['entity']),
  );

  archTest(
    classes.that
        .areInsideFolder('repository')
        .should
        .haveNameEndingWith('Repository')
        .and
        .extendClass<BaseRepository>(),
  );

  archTest(
    libraries.that
        .areInsideFolder('repository')
        .should
        .onlyHaveDependenciesFromFolders(['entity', 'repository']),
  );

  archTest(
    classes.that
        .areInsideFolder('service')
        .should
        .haveNameEndingWith('Service'),
  );

  archTest(
    libraries.that
        .areInsideFolder('service')
        .should
        .onlyHaveDependenciesFromFolders(['entity', 'repository', 'service']),
  );

  archTest(
    classes.that
        .areInsideFolder('controller')
        .should
        .haveNameEndingWith('Controller'),
  );
}
