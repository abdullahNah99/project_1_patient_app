import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/core/api/services/get_departments_service.dart';
import 'package:patient_app/core/api/services/get_my_information.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/core/api/services/log_out_service.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import '../../../../../core/api/services/get_doctors_service.dart';
import 'home_patient_states.dart';

class HomePatientCubit extends Cubit<HomePatientStates> {
  final String _adminToken ='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZGM1NDQ0OWVkNjQ5MGRlNjhkZjk2MDA1YWFkODE4M2YwNTdlY2I0Njg5ZjlhYWJlMzhkYzBiNmQ5Y2QyYTk0ZjE0MTE4NTMxOTllZGM2YWIiLCJpYXQiOjE2OTA0NjIxOTIuNjU3NTAxLCJuYmYiOjE2OTA0NjIxOTIuNjU3NTE2LCJleHAiOjE3MjIwODQ1OTIuNjQ4NjgxLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.nPEjU-J9ork9jX_rP98PFqxqq-mC_5mnsdnPWHPpODFKNsFZH_UP6TvbV6u9RCdrV3PaSz31u8bHV28-IfcZTtW33zQjnA-W1M8RPiKuIV1TF40mA8WCAU2FFJRJRPe8HIDWAhIaj87JrWicWGkpJ8e3jS-MHO4LTdUF-LYS0UaidBVmUsQuq-NmWE9WsH85HYYGGEptneVon53hT0dcL7gpRKuvDJ0Boxyw61i9mxDSncxCnPzn9Am-a40RtrDdPAQDwo8D8Y03FQtLCp166P7evDjJ3PC7DJklGpwwuxQ0LcWgbxZ2NozxQtH6mXTHBcaUKP4ddBDhD7mvojlKVWWNWuyL5X9Y9GOKxcdYsS29gV_z4aQB47cXQZKHhmWZVWiIs_HSWfrWIMna0KPrgf59FVIE6VzfQczWcggEbS7u5VIE-IFRe4CBOZZHpgYYdb9ZsXgaRmvkPaRt2W1_1iKmcK6Zelh9fkbroBySpmRd2VV7x6k3h1G9jE2aKiIViGNyLNH-iv31cPgGkOSzYMVl8CL8Mf4iveCCS6kYGZfVwyWtbapxGGQDlcyQtO7PXGoep2T7aJmGpSTz6dBEmk8nV46dWeTRxC8a2DvXmrC1zPHH-sPB8YHCWfT4g9ap-_RpC0nlyaT-F5wjgai-3PLR-vP00mcvDavECteRQws';

  int? bottomNavigationBarIndex;
  PatientModel? patientModel;
  HomePatientCubit() : super(HomePatientInitial());

  Future<void> getDoctors() async {
    emit(HomePatientLoading());
    (await GetDoctorsService.getDoctors(token: _adminToken)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (doctors) {
        emit(GetDoctorsSuccess(doctors: doctors));
      },
    );
  }

  Future<void> fetchMyInfo() async {
    emit(HomePatientLoading());
    String token = await CacheHelper.getData(key: 'Token');
    int userID = int.parse(JwtDecoder.decode(token)['sub']);
    (await GetMyInformationService.getMyInfo(userID: userID)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (patientModel) async {
        this.patientModel = patientModel;
        await getDoctors();
      },
    );
  }

  Future<void> getDepartments({required String token}) async {
    emit(HomePatientLoading());
    (await GetDepartmentsService.getDepartments(token: _adminToken)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (departments) {
        emit(GetDepartmentsSuccess(departments: departments));
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    emit(HomePatientLoading());
    (await LogOutService.logout(token: await CacheHelper.getData(key: 'Token')))
        .fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (success) async {
        await CacheHelper.deletData(key: 'Token');
        await CacheHelper.deletData(key: 'Role');
        emit(LogOutState());
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, LoginView.route);
      },
    );
  }
}
