/*

import 'package:patient_app/core/models/search_model.dart';
import '../../errors/failures.dart';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../http_api_services.dart';

abstract class SearchOnPatientService {
  static Future<Either<Failure, List<SearchOnPatientModel>>> search({
    required String token,
    required String name,
  }) async
  {
    try {
      var data = await ApiServices.post(
          endPoint: 'sessions/search',
          token: token,
          body:
      {
        'name': name,
      });
      List<SearchOnPatientModel> users = [];
      for (var item in data['users']) {
        users.add(SearchOnPatientModel.fromJson(item));
      }
     // return right(users);
    } catch (ex) {
      log('Exception: there is an error in search method');
      log(ex.toString());
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
*/
