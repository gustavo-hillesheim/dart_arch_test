import '../entities/entities.dart';

abstract interface class GetUsersUseCase {
  Future<List<UserEntity>> call();
}
