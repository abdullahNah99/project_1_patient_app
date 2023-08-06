import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/services/local/cache_helper.dart';
import '../../../core/api/dio_helper.dart';
import '../../../core/models/secretaria/secretaria_appointment/approve_the_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/cancel_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/handel_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/index_appointment_by_date_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/index_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/view_info_handle_model.dart';
import '../../../core/models/secretaria/secretaria_doctor/view_doctor_model.dart';
import '../../../core/models/secretaria/secretaria_patient/charge_wallet_model.dart';
import '../../../core/models/secretaria/secretaria_patient/index_patient_model.dart';
import '../../../core/models/secretaria/secretaria_patient/register_patient_model.dart';
import '../../../core/models/secretaria/secretaria_patient/view_patient_model.dart';
import '../../login_screen/login_screen.dart';
import '../appointments_list_date/appointments_list_date.dart';
import '../appointments_requests_screen/appointments_requests_view.dart';
import '../patient_list/patient_list.dart';
import 'api_states.dart';

class SecretariaLyoutCubit extends Cubit<SecretariaLyoutStates>
{
  SecretariaLyoutCubit() : super(SecretariaLyoutInitialStates());

  static SecretariaLyoutCubit get(context) => BlocProvider.of(context);

  final String adminToken = '';

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Patient',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.calendar_month_sharp,
      ),
      label: 'Appointment',
    ),
  ];

  List<Widget> page = [
    const PatientList(),
    AppointmentsListDate(),
    /*AppointmentsRequestsView(token: CacheHelper.getData(key: 'Token')),*/
  ];

  void changBottomNavBar(int index)
  {
    currentIndex = index;
    emit(SecretariaLyoutChangeNavBarStates());
  }

  IconData suffixIcon = Icons.visibility;
  bool isPassShow = false;

  void changePassVisibility()
  {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(SecretariaLyoutChangePassVisibilityState());
  }

  bool isBottomSheetShown = false;

  void changeBottomSheet({required bool isShow})
  {
    isBottomSheetShown = isShow;
    emit(ChangeBottomSheetState());
  }

  bool showAppointments = false;

  void showAppointment()
  {
    showAppointments = ! showAppointments;
    emit(ShowAppointmentState());
  }

  late IndexPatientModel indexPatientModel;

  void indexPatientsList()
  {
    emit(PatientListLoadingState());
    DioHelperG.getDataG(
        url: 'indexPatient',
        query: null,
        token: adminToken
    ).then((value) {
      indexPatientModel = IndexPatientModel.fromJson(value.data);
      print(value.toString());
      print(indexPatientModel.patient[0].user.firstName);
      emit(PatientListSuccssesState());
    }).catchError((error){
      print(error.toString());
      emit(PatientListErrorState());
    });
  }

  late ViewPatientModel viewPatientModel;

  void viewPatient({
    required int user_id,
  })
  {
    emit(PatientProfLoadingState());
    DioHelperG.postDataG(
        url: 'viewPatient',
        data: {
          'user_id': user_id,
        },
        token: adminToken
    ).then((value) {
      print(value.data);
      viewPatientModel = ViewPatientModel.fromJson(value.data);
      print(viewPatientModel.message);
      print(viewPatientModel.patient.user.firstName);
      emit(PatientProfSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(PatientProfErrorState());
    });
  }

  late RegisterPatientModel registerPatientModel;

  void registerPatient({
    required String first_name,
    required String last_name,
    required String phone_num,
    required String birth_date,
    required String gender,
    required String address,
    required String email,
    required String password,
    required String FCMToken,
  })
  {
    emit(PatientRegisterLoadingState());
    DioHelperG.postDataG(
        url: 'registerPatient',
        data: {
          'first_name': first_name,
          'last_name': last_name,
          'phone_num': phone_num,
          'birth_date': birth_date,
          'gender': gender,
          'address': address,
          'email': email,
          'password': password,
          'FCMToken': FCMToken,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      registerPatientModel = RegisterPatientModel.fromJson(value.data);
      print(value.toString());
      print(registerPatientModel.token);
      print(registerPatientModel.role);
      emit(PatientRegisterSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(PatientRegisterErrorState());
    });
  }

  late ChargeWalletModel chargeWalletModel;

  void chargeWallet({
    required double value,
    required int id,
  })
  {
    emit(ChargeWalletLoadingState());
    DioHelperG.postDataG(
        url: 'wallet/patient/$id',
        data: {
          'value': value,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      chargeWalletModel = ChargeWalletModel.fromJson(value.data);
      print(chargeWalletModel.success);
      print(chargeWalletModel.message);
      emit(ChargeWalletSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(ChargeWalletErrorState());
    });
  }

  //late IndexPatientModel indexPatientModel;

  void logOut({
    required BuildContext context
  })
  {
    emit(LogOutLoadingState());
    DioHelperG.getDataG(
        url: 'logout',
        query: null,
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      //indexPatientModel = IndexPatientModel.fromJson(value.data);
      print(value.toString());
      //print(indexPatientModel.patient[0].user.firstName);
      emit(LogOutSuccssesState());
      CacheHelper.deletData(key: 'Token');
      CacheHelper.deletData(key: 'Role');
      Navigator.pop(context, LoginView.route);
    }).catchError((error){
      print(error.toString());
      emit(LogOutErrorState());
    });
  }

  late IndexAppointmentModel indexAppointmentModel;

  void indexAppointment()
  {
    emit(ApppintmentListLoadingState());
    DioHelperG.getDataG(
        url: 'indexAppointment',
        query: null,
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      indexAppointmentModel = IndexAppointmentModel.fromJson(value.data);
      print(value.toString());
      print(indexAppointmentModel.appointment[0].date);
      emit(ApppintmentListSuccssesState());
    }).catchError((error){
      print(error.toString());
      emit(ApppintmentListErrorState());
    });
  }

  late IndexAppointmentByDateModel indexAppointmentByDateModel;

  void indexAppointmentByDate({
    required String date,
  })
  {
    emit(ApppintmentListByDateLoadingState());
    DioHelperG.postDataG(
        url: 'indexAppointmentByDate',
        data: {
          'date': date,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      indexAppointmentByDateModel = IndexAppointmentByDateModel.fromJson(value.data);
      print(indexAppointmentByDateModel.appointment[0].status);
      print(indexAppointmentByDateModel.success);
      emit(ApppintmentListByDateSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(ApppintmentListByDateErrorState());
    });
  }

  late ViewInfoHandleModel viewInfoHandleModel;

  void viewInfoHandle({
    required int id,
  })
  {
    emit(viewInfoHandleModelLoadingState());
    DioHelperG.getDataG(
        url: 'handled/view/$id',
        query: null,
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      viewInfoHandleModel = ViewInfoHandleModel.fromJson(value.data);
      print(value.toString());
      print(viewInfoHandleModel.appointment.doctor.consultationPrice);
      emit(viewInfoHandleModelSuccssesState());
    }).catchError((error){
      print(error.toString());
      emit(viewInfoHandleModelErrorState());
    });
  }

  late ApproveTheAppointmentModel approveTheAppointmentModel;

  void approveTheAppointment({
    required int id,
  })
  {
    emit(approveTheAppointmentLoadingState());
    DioHelperG.postDataG(
        url: 'approveTheAppointment/$id',
        data: {},
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      approveTheAppointmentModel = ApproveTheAppointmentModel.fromJson(value.data);
      print(approveTheAppointmentModel.message);
      print(approveTheAppointmentModel.success);
      emit(approveTheAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(approveTheAppointmentErrorState());
    });
  }

  late CancelAppointmentModel cancelAppointmentModel;

  void cancelAppointment({
    required String cancel_reason,
    required int id,
  })
  {
    emit(cancelAppointmentLoadingState());
    DioHelperG.postDataG(
        url: 'cancelAppointment/$id',
        data: {
          'cancel_reason': cancel_reason,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      cancelAppointmentModel = CancelAppointmentModel.fromJson(value.data);
      print(cancelAppointmentModel.message);
      print(cancelAppointmentModel.success);
      emit(cancelAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(cancelAppointmentErrorState());
    });
  }

  late HandelApppintmentModel handelApppintmentModel;

  void handelApppintment({
    required String date,
    required String time,
    required String status,
    required int id,
  })
  {
    emit(HandelApppintmentLoadingState());
    DioHelperG.postDataG(
        url: 'AppointmentHandle',
        data: {
          'date': date,
          'time': time,
          'status': status,
          'id': id,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      handelApppintmentModel = HandelApppintmentModel.fromJson(value.data);
      print(handelApppintmentModel.appointment.cancelReason);
      print(handelApppintmentModel.success);
      emit(HandelApppintmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(HandelApppintmentErrorState());
    });
  }

  late ViewDoctorModel viewDoctorModel;

  void viewDoctor({
    required int user_id,
  })
  {
    emit(DoctorProfLoadingState());
    DioHelperG.postDataG(
        url: 'viewDoctor',
        data: {
          'user_id': user_id,
        },
        token: adminToken
    ).then((value) {
      print(value.data);
      viewDoctorModel = ViewDoctorModel.fromJson(value.data);
      print(viewDoctorModel.message);
      print(viewDoctorModel.doctor.user.firstName);
      emit(DoctorProfSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(DoctorProfErrorState());
    });
  }
}