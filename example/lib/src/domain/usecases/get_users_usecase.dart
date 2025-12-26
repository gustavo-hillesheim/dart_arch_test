import '../entities/entities.dart';

abstract interface class GetUsersUsecase {
  Future<List<UserEntity>> call();
}
