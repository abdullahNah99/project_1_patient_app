

//gh api method**********************************************************************************
class DioHelperG {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.43.37:8000/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getDataG({
    required String url,
    required Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postDataG({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
