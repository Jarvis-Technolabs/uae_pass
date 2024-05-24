abstract class IRemoteDataSource {
  Future<dynamic> executeGet({
    required String path,
    String? token,
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> executePost({
    required String path,
    String? token,
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
  });
}
