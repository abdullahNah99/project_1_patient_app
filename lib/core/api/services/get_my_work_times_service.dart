import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/work_day_model.dart';
import '../../errors/failures.dart';
import '../http_api_services.dart';


abstract class GetMyWorkTimes {
  static Future<Either<Failure, List<WorkDayModel>>> getMyWorkTimes(
      {required String token}) async {
    try {
      List<WorkDayModel> times = [];
      var data = await ApiServices.get(endPoint: 'indexMyTime', token: token);
      for (var item in data['workDay']) {
        times.add(WorkDayModel.fromJson(item));
      }

      return right(times);
    } catch (ex) {
      log('Exception: there is an error in getMyWorkTimes method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
