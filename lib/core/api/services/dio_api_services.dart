import 'package:dio/dio.dart';
class DioHelper
{
  static late Dio dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
       /* headers:
        {
          'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjlhMDRkNjU2ZjZmOGMyMWFmNGFiZGQ5MGU1ZmJmYTAyYmJlYTc0NWYwZTRmNDhiMDU4N2ZhMGZhYWM4YjE1MTVhNjUzMTM5MjA4YTQ3YWIiLCJpYXQiOjE2OTA5OTg0NDUuNzY5MDkyLCJuYmYiOjE2OTA5OTg0NDUuNzY5MDk5LCJleHAiOjE3MjI2MjA4NDUuNzMxNzAyLCJzdWIiOiIxNiIsInNjb3BlcyI6W119.QEe9n0V4qvm_Kpzx7hJnvqxstM2Qw7H27J_ZtjQovDc6s50tlv9wmWH1ccpvGoeJQ-BuASa-bP1DDPhERTiR6nrSWxkmETOrmEw0QSpVgxRG_9LMybIKu8dMpuFLPdo6KqDquETzVlOQ5hQZ3qvZVqqa42fXgOEWdtUd4ruXzNso02nFErJwESqnNLrKtO3lLFojrt3QwCf9-NSvCFHDHFmFkxdodb_jLSqPcUyl3d4J7SsjXoNaduP5wrQm7qcTE5d9kUBQQzDZWFtdSAckytxUYd59KJfGLS3uxJ33BAQbBobA3jiqy9YQoZEOPGbMcBy9N2-tGAZsMvZFKdXrxtg6ba3nlgavtydxcdXNv16jZdYrIalOkkFXT0v5z4LeiBsL_WBR7J4AsMWfqkR1c47oNZAzx9M4YYbn6eiAIXiax487ofT0okRvhBzzxQQJpZlhHo-6qCutj2rhGUZf7FOKDhzgcobxIKHTnFyL703CtqNfZVrzP7uK1QNAmJf_anm1LyQHKDjy9AeTUHlsZGplFApu8a28qbdw4UT3ms4wos_rlGUC1Z8XX08A-EHqQKCXmvlh9IA5e04njjiaV0R_JdkdhF1RqrG6pkPgeU4mNLjKA-6b8Eb3yvcciD_CMGVMAvDC_t9vD401RlSYEth_qhf6TpA9ZypjVWDyfE8'
              },*/
        baseUrl:'http://192.168.1.10:8000/api/',
        receiveDataWhenStatusError: true,


      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? query,
    String? token,
  }) async
  {
    dio.options.headers=
    {
      'Authorization':'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? data,
    Map<String,dynamic>? query,
    required String token ,
  }) async
  {
      dio.options.headers=
    {
      'Authorization':'Bearer $token',
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}

