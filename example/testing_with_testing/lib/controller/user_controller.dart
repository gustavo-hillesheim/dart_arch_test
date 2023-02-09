import 'package:testing_with_testing/entity/user_entity.dart';
import 'package:testing_with_testing/service/user_service.dart';

class UserController {
  final UserService service;

  UserController(this.service);

  Future<void> save(UserEntity user) async {
    await service.save(user);
  }
}
