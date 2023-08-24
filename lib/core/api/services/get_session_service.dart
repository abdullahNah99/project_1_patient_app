import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/session_model.dart';
import '../../errors/failures.dart';
import '../../models/patient_model.dart';
import '../http_api_services.dart';

abstract class GetSessionService {
  static Future<Either<Failure, List<SessionModel>>> getSession(
      {required String token, required int patientId}) async {
    try {
      var data = await ApiServices.get(
          endPoint: 'sessions/patient/$patientId',
          token: token,
      );
      List<SessionModel> session = [];

      for (var item in data['session'])
      {
        session.add(SessionModel.fromJson(item));
      }
      return right(session);
    } catch (ex) {
      log('Exception: there is an error in getSession method');
      log(ex.toString());
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}

