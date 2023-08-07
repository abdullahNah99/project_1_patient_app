import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/screens/doctor_screens/doctor_cubit/states.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/api/services/log_out_service.dart';

class DoctorCubit extends Cubit<DoctorStates>
{
  DoctorCubit() : super(DoctorHomeInitialState());
  static DoctorCubit get(context) =>BlocProvider.of(context);

  final String _adminToken ='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWIzNTExMThmNzQxYjY4Y2E5YWUyN2MwYzgwMmU2NDhlZjNhM2IwNTI3MmM4YWJhYzJmNTY5MTQzOWNmYzIzYjQ4MTExY2Y3YWJkOTZlMDkiLCJpYXQiOjE2OTA1NDQ4MjkuOTYyMTEyLCJuYmYiOjE2OTA1NDQ4MjkuOTYyMTE3LCJleHAiOjE3MjIxNjcyMjkuOTUxMTQyLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.XHAYDgG7aQzzw4u_WBU1dSjVD454utu5QcvdyhfOv3w8r7v0vIZ0mdDCh6zCQNqP4nS78VyuBWruO35RmouybgLqpeI57ow6QnVZkYeU_gIvwMIJnQQinizG-U2jOa06ee5vKTL0qp2Ph54KkIoLdRS6ooNMprFgDRKOCeorIEZmCCssJc3K0F-q2iExpTMaRyVlS5fPrSoIUZnKGadpMC9BF1QWklr1P_j13ZYc5zYInKi92zsjhxidRDEfmkaeh3bfGKHvm_K8HlXqzOdfnmmFgTDw0Z01IlbvxJ_R5UULV1P9yYWrgO8vK5fhJUnQgSl1ffWCVZdCpVbQA3KVethYgyGjUqnLiTa4jeEGdoV5V0xHsfZR4GpaMtTrcyaFAnHgRKaraHosvvd2ZzaE-AcyKtrua1zlIRJ9-Ob3nLs7D2oXRPQwo0R1ZqL8W94zOM-M2OB9L2UhYgWR0xl7M5_OBXxhzl-WUM4C-rxnJB2kNKHPhLgeQKsSMIHrobKT6dVfFPEeEATuaQQjwICTlq4-PS5fWv5UOlpY_cODrrqv73kmx2BQWQW45ZcWbooQ0NnyFKPBlLXqykwlo6izyL19AQ9vwTjJVXbn4pMJUCzmp8uB8xyfUGgDEeSEjY7mD0x4NeC71D5orCn5_qekUk75ugqNfU7r8ykynZljjGc';


  Future<void> logout(BuildContext context) async {
    emit(DoctorHomeLoadingState());
    (
        await LogOutService.logout(token: await CacheHelper.getData(key: 'Token')))
        .fold((error)
      {
        emit(DoctorHomeErrorState(error: error.errorMessege));
      },
          (success) async {
        await CacheHelper.deletData(key: 'Token');
        await CacheHelper.deletData(key: 'Role');
        emit(DoctorHomeLogOutState());
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, LoginView.route);
      },
    );
  }
  //getSession
  //getAppointment
  //getConsul
   //work time



}