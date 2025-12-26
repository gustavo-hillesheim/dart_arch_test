import 'package:example/src/domain/entities/entities.dart';

abstract interface class UsersRepository {
  Future<List<UserEntity>> getUsers();
}
