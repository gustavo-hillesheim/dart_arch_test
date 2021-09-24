import 'package:testing_with_testing/controller/user_controller.dart';
import 'package:testing_with_testing/entity/enum/user_type.dart';
import 'package:testing_with_testing/entity/user_entity.dart';
import 'package:testing_with_testing/repository/user_repository.dart';
import 'package:testing_with_testing/service/user_service.dart';

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
