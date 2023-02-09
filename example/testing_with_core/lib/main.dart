import 'package:testing_with_core/controller/user_controller.dart';
import 'package:testing_with_core/entity/enum/user_type.dart';
import 'package:testing_with_core/entity/user_entity.dart';
import 'package:testing_with_core/repository/user_repository.dart';
import 'package:testing_with_core/service/user_service.dart';

void main() {
  final controller = UserController(UserService(UserRepository()));
  controller.save(
    UserEntity(
      id: 1,
      name: 'Gustavo',
      type: UserType.ADMINISTRATOR,
    ),
  );
}
