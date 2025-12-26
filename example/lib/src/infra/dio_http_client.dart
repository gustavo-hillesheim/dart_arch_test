import 'package:dio/dio.dart';

import 'infra.dart';

class DioHttpClient implements HttpClient {
  const DioHttpClient(this._dio);

  final Dio _dio;

  @override
  Future<HttpResponse> get(String path) async {
    final response = await _dio.get(path);
    return HttpResponse(data: response.data);
  }
}
