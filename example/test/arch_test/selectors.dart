import 'package:arch_test/arch_test.dart';

final entities = NamedElementSelector(
  classes.that(haveNameEndingWith('Entity')),
  'entities',
);
final repositories = NamedElementSelector(
  classes.that(haveNameEndingWith('Repository')),
  'repositories',
);
final repositoryImpls = NamedElementSelector(
  classes.that(haveNameEndingWith('RepositoryImpl')),
  'repository implementations',
);
final usecases = NamedElementSelector(
  classes.that(haveNameEndingWith('UseCase')),
  'usecases',
);
final usecasesImpls = NamedElementSelector(
  classes.that(haveNameEndingWith('UseCaseImpl')),
  'usecases implementations',
);
final datasources = NamedElementSelector(
  classes.that(haveNameEndingWith('DataSource')),
  'datasources',
);
final datasourcesImpls = NamedElementSelector(
  classes.that(haveNameEndingWith('DataSourceImpl')),
  'datasources implementations',
);
final controllers = NamedElementSelector(
  classes.that(haveNameEndingWith('Controller')),
  'controllers',
);
