import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/doctor_model.dart';
import '../../errors/failures.dart';
import '../../utils/constants.dart';
import '../http_api_services.dart';

abstract class GetDoctorInformationService {
  static Future<Either<Failure, DoctorModel>> getUserInfo({
    required int userID,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'viewDoctor',
        body: {
          'user_id': '$userID',
        },
        token: Constants.adminToken,
      );

      return right(DoctorModel.fromJson(data['doctor']));
    } catch (ex) {
      log('Exception: there is an error in getMyInfo method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
/**
 * [log] HTTP POST Data: {
 * success: true,
 * message: Doctor retrieved successfully.,
 * doctor:
 * {
 * id: 1,
 * specialty: heart sergary,
 * description: from England,
 * image_path: images/S5N9VLnnXTy6eVnXc6czum1qgLbjU2M2sXm2ICOl.png,
 * department_id: 1,
 * consultation_price: 2000,
 * review: 1,
 * doctor_wallet: 0,
 * user_id: 2,
 * created_at: 2023-08-11T06:09:39.000000Z,
 * updated_at: 2023-08-11T06:09:39.000000Z,
 * user: {id: 2,
 * first_name: fatma,
 * last_name: ra,
 * phone_num: 0967751232,
 * email: fatma@gmail.com,
 * email_verified_at: null,
 * role: doctor,
 * created_at: 2023-08-11T06:09:39.000000Z,
 * updated_at: 2023-08-11T06:09:39.000000Z}}}*/