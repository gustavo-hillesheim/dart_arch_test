import '../../../domain/entities/entities.dart';
import '../../../infra/infra.dart';
import '../datasources.dart';

class UsersDataSourceImpl implements UsersDataSource {
  const UsersDataSourceImpl(this._httpClient);

  final HttpClient _httpClient;

  @override
  Future<List<UserEntity>> fetchUsers() async {
    final response = await _httpClient.get('/users');
    final List<dynamic> data = response.data['data'] as List<dynamic>;
    return data
        .map((json) => UserEntity.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
