import 'package:equatable/equatable.dart';
import 'package:testing_with_core/entity/enum/user_type.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final UserType type;

  UserEntity({required this.id, required this.name, required this.type});

  @override
  List<Object?> get props => [id, name, type];
}
