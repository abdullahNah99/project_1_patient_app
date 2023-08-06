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
  final String _adminToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODNmOTU5MDhjMzc0OWIyZTgzZjg1OWU0OWU1N2M0NGFkMGQ1OWRmNmM4NzRiMWYyN2JlOTM0OTExNzQ4NjdmZjA1YzdlZjA0NGJhMzAwZWQiLCJpYXQiOjE2OTExMzQ1ODkuNDYyNjI3LCJuYmYiOjE2OTExMzQ1ODkuNDYyNjM0LCJleHAiOjE3MjI3NTY5ODkuNDA1MTE1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.eVaoHOAfyKyBxaXP9h4b8cIFapNoQIuzOAbiB68ED-6UxAqo7ZdZJSFfcHy6v4pvgUoMVeKrlkos9BeiATG0I3G21PIrqxGtyRqCY_vhSvkOS9RjZ4LsS1z9KPPHJPgiQ3cvkljHscqaPqNvOoujnn-VEKnLZ8EHwMT2SGjzqNRZrZunl_4VGKEMDr16e_0j7BHJ422soKTAbaw_QbjDTnI9DnGCdCGLVw5IjVTbFd5PQY1lWMTMqBLRH1aIS5zk3R8O3PHClzWawjQ9bXbQHvlX5c0iu0bV7JJgCaIN1m7MwJbH9dQBqXxqgiuZsFFSXMs0Ui0HR8732G4XhPARIP-W3BXjhxjoGrjcOVxTYUgpw-Er5KjWss12ko3e8pzwEO7w-BDMu1d76w1IdF1wKtLNHhSyxeVGANOlgYR4BFpdtWgTOkpxNbXrnXUPgHiK1_5f5QTeHHrec_qNWKmoW8GGT1P2fK21l1ZUmc1er5KNkjeZygGoQsUGcli9eWk0abVXiizLWzTY5GTmDEzBDCuosx1FzrGc_oO-Jef0a3yRIlQKszmeOCoaekj4Fq_z8CEwv7oxWOkTShReEpx5wSZK3CLPD86TfDm4ENy0rkl1zrHHv5ck5V9Z6VyxygYSj_HfLQV7K8RCVCQ8rEJo321hz5v7nRQpe9-fnNHHuCU';

  int? bottomNavigationBarIndex;
  PatientModel? patientModel;
  HomePatientCubit() : super(HomePatientLoading());

  int? departmentID;

  Future<void> getDoctors() async {
    emit(HomePatientLoading());
    (await GetDoctorsService.getDoctors(token: _adminToken)).fold(
      (failure) {
        emit(HomePatientFailure(failureMsg: failure.errorMessege));
      },
      (doctors) async {
        (await GetDepartmentsService.getDepartments(token: _adminToken)).fold(
          (failure) {
            emit(HomePatientFailure(failureMsg: failure.errorMessege));
          },
          (departments) {
            emit(
              GetDoctorsAndDepartmentsSuccess(
                doctors: doctors,
                departments: departments,
              ),
            );
          },
        );
        //emit(GetDoctorsSuccess(doctors: doctors));
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

  // Future<void> getDepartments({required String token}) async {
  //   emit(HomePatientLoading());
  //   (await GetDepartmentsService.getDepartments(token: _adminToken)).fold(
  //     (failure) {
  //       emit(HomePatientFailure(failureMsg: failure.errorMessege));
  //     },
  //     (departments) {
  //       emit(GetDepartmentsSuccess(departments: departments));
  //     },
  //   );
  // }

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

  Future<void> viewDoctorsForDebarment({required departmentsId}) async {
    departmentID = departmentsId;
    await getDoctors();
  }
}
