import 'package:testing_with_fluent/controller/user_controller.dart';
import 'package:testing_with_fluent/entity/enum/user_type.dart';
import 'package:testing_with_fluent/entity/user_entity.dart';
import 'package:testing_with_fluent/repository/user_repository.dart';
import 'package:testing_with_fluent/service/user_service.dart';

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
