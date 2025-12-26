import 'package:example/src/domain/usecases/usecases.dart';

class UserController {
  const UserController(this.getUsersUsecase);

  final GetUsersUsecase getUsersUsecase;

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final users = await getUsersUsecase();
    return users.map((u) => u.toJson()).toList();
  }
}
