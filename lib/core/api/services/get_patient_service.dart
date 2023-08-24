import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/patient_model.dart';
import '../http_api_services.dart';

abstract class GetPatientService {
  static Future<Either<Failure, List<PatientModel>>> getPatient(
      {required String token}) async {
    try {
      var data = await ApiServices.get(endPoint: 'doctor/DoctorPatient', token: token);

      List<PatientModel> patient = [];

      for (var item in data['patients'])
      {
        patient.add(PatientModel.fromJson(item));
      }
      return right(patient);
    } catch (ex) {
      log('Exception: there is an error in getPatients method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}



/*

abstract class SearchOnPatientService {
  static Future<Either<Failure, List<User>>> search(

      {required String token,required String name}) async
  {
    try {
      var data = await ApiServices.post(
          endPoint: 'sessions/search',
          token: token,
          body:
      {
        'name': name,
      });
      List<PatientModel> users = [];
      for (var item in data['users']) {
        users.add(PatientModel.fromJson(item));
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
