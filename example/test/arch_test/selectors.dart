import 'package:arch_test/arch_test.dart';

final entities = classes.that(haveNameEndingWith('Entity'));
final repositories = classes.that(haveNameEndingWith('Repository'));
final repositoryImpls = classes.that(haveNameEndingWith('RepositoryImpl'));
final usecases = classes.that(haveNameEndingWith('UseCase'));
final usecasesImpls = classes.that(haveNameEndingWith('UseCaseImpl'));
final datasources = classes.that(haveNameEndingWith('DataSource'));
final datasourcesImpls = classes.that(haveNameEndingWith('DataSourceImpl'));
final controllers = classes.that(haveNameEndingWith('Controller'));
