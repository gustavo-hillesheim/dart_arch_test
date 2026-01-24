import 'package:arch_test/arch_test.dart';
import 'package:arch_test/predicate_builders.dart';

final entities = NamedElementSelector(
  classes.that(have(name(), endingWith('Entity'))),
  'entities',
);
final repositories = NamedElementSelector(
  classes.that(have(name(), endingWith('Repository'))),
  'repositories',
);
final repositoryImpls = NamedElementSelector(
  classes.that(have(name(), endingWith('RepositoryImpl'))),
  'repository implementations',
);
final usecases = NamedElementSelector(
  classes.that(have(name(), endingWith('UseCase'))),
  'usecases',
);
final usecasesImpls = NamedElementSelector(
  classes.that(have(name(), endingWith('UseCaseImpl'))),
  'usecases implementations',
);
final datasources = NamedElementSelector(
  classes.that(have(name(), endingWith('DataSource'))),
  'datasources',
);
final datasourcesImpls = NamedElementSelector(
  classes.that(have(name(), endingWith('DataSourceImpl'))),
  'datasources implementations',
);
final controllers = NamedElementSelector(
  classes.that(have(name(), endingWith('Controller'))),
  'controllers',
);
