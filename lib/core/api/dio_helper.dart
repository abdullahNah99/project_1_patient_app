import 'package:dio/dio.dart';

import '../utils/constants.dart';

class DioHelper
{
  static late Dio dio;
  static init()
  {
    dio =Dio(
      BaseOptions(
        baseUrl: '${Constants.paseUrl}api/',
        receiveDataWhenStatusError: true,

      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String,dynamic>? query,
    String? token ,
  }) async
  {
    dio.options.headers=
    {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String,dynamic>? data,
    Map<String,dynamic>? query,
    String? token ,
  }) async
  {
    dio.options.headers=
    {
      'Authorization': 'Bearer $token',
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}