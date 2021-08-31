import 'package:testing_with_core/entity/user_entity.dart';
import 'package:testing_with_core/repository/user_repository.dart';

class UserService {
  final UserRepository repository;

  UserService(this.repository);

  Future<void> save(UserEntity user) async {
    await repository.save(user);
  }
}
