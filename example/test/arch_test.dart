import 'package:arch_test/arch_test.dart';
import 'package:arch_test/predicate_builders.dart';

import 'arch_test/selectors.dart';

void main() {
  archTest(
    entities.should(have(libraryPath(), containing('src/domain/entities'))),
  );
  archTest(
    repositories.should(
      have(libraryPath(), containing('src/domain/repositories')),
    ),
  );
  archTest(
    repositoryImpls.should(
      have(libraryPath(), containing('src/data/repositories')),
    ),
  );
  archTest(
    usecases.should(have(libraryPath(), containing('src/domain/usecases'))),
  );
  archTest(
    usecasesImpls.should(
      have(libraryPath(), containing('src/domain/usecases/impl')),
    ),
  );
  archTest(
    datasources.should(have(libraryPath(), containing('src/data/datasources'))),
  );
  archTest(
    datasourcesImpls.should(
      have(libraryPath(), containing('src/data/datasources/impl')),
    ),
  );
  archTest(
    controllers.should(
      have(libraryPath(), containing('src/presentation/controllers')),
    ),
  );

  archTest(
    repositories
        .and(usecases)
        .and(datasources)
        .should(be(abstract()).and(be(interface()))),
  );

  runArchTests();
}
