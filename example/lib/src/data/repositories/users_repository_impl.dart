import 'package:example/src/domain/repositories/repositories.dart';

import '../../domain/entities/entities.dart';
import '../datasources/datasources.dart';

class UsersRepositoryImpl implements UsersRepository {
  const UsersRepositoryImpl(this._dataSource);

  final UsersDataSource _dataSource;

  @override
  Future<List<UserEntity>> getUsers() {
    return _dataSource.fetchUsers();
  }
}
