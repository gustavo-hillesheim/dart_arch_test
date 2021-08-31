import 'package:testing_with_core/entity/user_entity.dart';
import 'package:testing_with_core/service/user_service.dart';

class UserController {
  final UserService service;

  UserController(this.service);

  Future<void> save(UserEntity user) async {
    await service.save(user);
  }
}
