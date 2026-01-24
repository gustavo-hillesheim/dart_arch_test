import 'package:example/src/domain/entities/user_entity.dart';

import '../../repositories/repositories.dart';
import '../get_users_usecase.dart';

class GetUsersUseCaseImpl implements GetUsersUseCase {
  const GetUsersUseCaseImpl(this._repository);

  final UsersRepository _repository;

  @override
  Future<List<UserEntity>> call() {
    return _repository.getUsers();
  }
}
