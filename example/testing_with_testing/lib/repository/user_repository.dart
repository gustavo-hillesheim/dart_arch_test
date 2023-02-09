import 'package:testing_with_testing/entity/user_entity.dart';
import 'package:testing_with_testing/repository/base_repository.dart';

class UserRepository extends BaseRepository<UserEntity> {
  @override
  Future<void> save(UserEntity entity) async {
    print('Saved user');
  }
}
