import 'package:example/src/domain/entities/user_entity.dart';

import '../../repositories/repositories.dart';
import '../get_users_usecase.dart';

class GetUsersUsecaseImpl implements GetUsersUsecase {
  const GetUsersUsecaseImpl(this._repository);

  final UsersRepository _repository;

  @override
  Future<List<UserEntity>> call() {
    return _repository.getUsers();
  }
}
