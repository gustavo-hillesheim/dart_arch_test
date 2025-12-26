import 'package:example/src/domain/entities/user_entity.dart';

abstract interface class UsersDataSource {
  Future<List<UserEntity>> fetchUsers();
}
