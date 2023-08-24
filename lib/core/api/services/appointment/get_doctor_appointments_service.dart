import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../errors/failures.dart';
import '../../../models/app_model.dart';
import '../../http_api_services.dart';

abstract class GetDoctorAppointmentsService {
  static Future<Either<Failure, List<AppModel<int>>>> getDoctorAppointments(
      {required String token, required int doctorID}) async {
    try {
      var data = await ApiServices.post(
          endPoint: 'indexAppointmentDoctor',
          token: token,
          body: {'doctor_id': '$doctorID'});

      List<AppModel<int>> myAppointments = [];

      for (var item in data['Appointment']) {
        myAppointments.add(AppModel<int>.fromJson(item));
      }
      return right(myAppointments);
    } catch (ex) {
      log('Exception: there is an error in getDoctorsAppointments method');
      log(ex.toString());
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
