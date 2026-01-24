abstract interface class HttpClient {
  Future<HttpResponse> get(String path);
}

class HttpResponse {
  const HttpResponse({this.data});

  final dynamic data;
}
