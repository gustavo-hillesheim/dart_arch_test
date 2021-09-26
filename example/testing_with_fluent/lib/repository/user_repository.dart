import 'package:testing_with_fluent/entity/user_entity.dart';
import 'package:testing_with_fluent/repository/base_repository.dart';

class UserRepository extends BaseRepository<UserEntity> {
  @override
  Future<void> save(UserEntity entity) async {
    print('Saved user');
  }
}
