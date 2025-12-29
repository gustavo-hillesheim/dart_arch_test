import 'package:arch_test/arch_test.dart';

import 'arch_test/selectors.dart';

void main() {
  archTest(entities.should(resideIn('src/domain/entities')));
  archTest(repositories.should(resideIn('src/domain/repositories')));
  archTest(repositoryImpls.should(resideIn('src/data/repositories')));
  archTest(usecases.should(resideIn('src/domain/usecases')));
  archTest(usecasesImpls.should(resideIn('src/domain/usecases/impl')));
  archTest(datasources.should(resideIn('src/data/datasources')));
  archTest(datasourcesImpls.should(resideIn('src/data/datasources/impl')));
  archTest(controllers.should(resideIn('src/presentation/controllers')));

  archTest(
    repositories
        .and(usecases)
        .and(datasources)
        .should(beAbstract.and(beInterface)),
  );

  runArchTests();
}
