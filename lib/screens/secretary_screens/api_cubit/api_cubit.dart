import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:patient_app/core/utils/constants.dart';

import '../../../../core/api/services/local/cache_helper.dart';
import '../../../core/api/dio_helper.dart';
import '../../../core/models/secretaria/secretaria_appointment/approve_the_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/cancel_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/date_approve_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/date_waiting_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/delete_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/handel_appointment_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/index_appointment_by_date_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/index_appointment_doctor_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/index_approve_appointment_by_date_model.dart';
import '../../../core/models/secretaria/secretaria_appointment/view_info_handle_model.dart';
import '../../../core/models/secretaria/secretaria_doctor/index_by_department.dart';
import '../../../core/models/secretaria/secretaria_doctor/view_doctor_model.dart';
import '../../../core/models/secretaria/secretaria_patient/charge_wallet_model.dart';
import '../../../core/models/secretaria/secretaria_patient/index_patient_model.dart';
import '../../../core/models/secretaria/secretaria_patient/register_patient_model.dart';
import '../../../core/models/secretaria/secretaria_patient/view_patient_model.dart';
import '../../../core/models/secretaria/secretaria_secretaria/view_secretary_model.dart';
import '../appointments_list_date/appointments_list_date.dart';
import '../appointments_requests_screen/appointments_requests_view.dart';
import '../doctor_list/doctor_list.dart';
import '../patient_list/patient_list.dart';
import 'api_states.dart';

class SecretariaLyoutCubit extends Cubit<SecretariaLyoutStates> {
  SecretariaLyoutCubit() : super(SecretariaLyoutInitialStates());

  static SecretariaLyoutCubit get(context) => BlocProvider.of(context);

   Map<String, dynamic>? perInfo;

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
        Icons.medical_information,
      ),
      label: 'Doctor',
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
    const DoctorList(),
    const AppointmentsListDate(),
    /*AppointmentsRequestsView(token: CacheHelper.getData(key: 'Token')),*/
  ];

  void changBottomNavBar(int index) 
    {
    currentIndex = index;
    emit(SecretariaLyoutChangeNavBarStates());
    if(index == 0)
    {
      indexPatient();
    }else if(index == 1)
    {
      viewSecretary(user_id: getMyId());
    }
  }

  IconData suffixIcon = Icons.visibility;
  bool isPassShow = false;

  void changePassVisibility() {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(SecretariaLyoutChangePassVisibilityState());
  }

  bool isBottomSheetShown = false;

  void changeBottomSheet({required bool isShow}) {
    isBottomSheetShown = isShow;
    emit(ChangeBottomSheetState());
  }

  bool showAppointments = false;
  bool isSelected = false;
  int indexList = 0;
  List days = [
    //Tuesday Oct 08
    DateFormat.EEEE().format(DateTime.now()),
    for(int i = 1; i <= 30 ; i++)
      DateFormat.EEEE().format(DateTime.now().add(Duration(days: i))),
  ];
  List month = [
    //Tuesday Oct 08
    DateFormat.MMM().format(DateTime.now()),
    for(int i = 1; i <= 30 ; i++)
      DateFormat.MMM().format(DateTime.now().add(Duration(days: i))),
  ];
  List dayNum = [
    //Tuesday Oct 08
    DateFormat.d().format(DateTime.now()),
    for(int i = 1; i <= 30 ; i++)
      DateFormat.d().format(DateTime.now().add(Duration(days: i))),
  ];
  final List colorItem = [
    false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false,
  ];

  void showAppointment()
  {
    showAppointments = ! showAppointments;
    isSelected = ! isSelected;
    colorItem[indexList] =! colorItem[indexList];
    emit(ShowAppointmentState());
  }

  bool showWaitingDays = false;
  bool isSelecte = false;
  bool showApproveDays = false;

  final List colorTypeItem = [
    false, false
  ];

  void showDay({
  required String type
  })
  {
    if(type == 'Waiting')
    {
      showWaitingDays = ! showWaitingDays;
      isSelecte = ! isSelecte;
      colorTypeItem[0] =! colorTypeItem[0];
      emit(ShowWaitingDayState());
    }else
    {
      showApproveDays = ! showApproveDays;
      isSelecte = ! isSelecte;
      colorTypeItem[1] =! colorTypeItem[1];
      emit(ShowApproveDayState());
    }
  }

  late IndexPatientModel indexPatientModel;

  void indexPatient()
  {
    emit(PatientListLoadingState());
    DioHelper.getData(
        url: 'indexPatient',
        query: null,
        token: Constants.adminToken
    ).then((value) {
      indexPatientModel = IndexPatientModel.fromJson(value.data);
      print(value.toString());
      print(indexPatientModel.patient[0].user.firstName);
      emit(PatientListSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(PatientListErrorState());
    });
  }

  late ViewPatientModel viewPatientModel;

  void viewPatient({
    required int user_id,
  }) {
    emit(PatientProfLoadingState());
    DioHelper.postData(
        url: 'viewPatient',
        data: {
          'user_id': user_id,
        },
        token: Constants.adminToken
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
  }) {
    emit(PatientRegisterLoadingState());
    DioHelper.postData(
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
  }) {
    emit(ChargeWalletLoadingState());
    DioHelper.postData(
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

  /*void logOut({
    required BuildContext context
  })
  {
    emit(LogOutLoadingState());
    DioHelper.getData(
            url: 'logout',
            query: null,
            token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      //indexPatientModel = IndexPatientModel.fromJson(value.data);
      print(value.toString());
      //print(indexPatientModel.patient[0].user.firstName);
      emit(LogOutSuccssesState());
      CacheHelper.deletData(key: 'Token');
      CacheHelper.deletData(key: 'Role');
      Navigator.pop(context, LoginView.route);
    }).catchError((error) {
      print(error.toString());
      emit(LogOutErrorState());
    });
  }
  */

  /*late IndexAppointmentModel indexAppointmentModel;

  void indexAppointment() {
    emit(ApppintmentListLoadingState());
    DioHelper.getData(
            url: 'indexAppointment',
            query: null,
            token: CacheHelper.getData(key: 'Token'))
        .then((value) {
      indexAppointmentModel = IndexAppointmentModel.fromJson(value.data);
      print(value.toString());
      print(indexAppointmentModel.appointment[0].date);
      emit(ApppintmentListSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(ApppintmentListErrorState());
    });
  }
  */

  late IndexAppointmentByDateModel indexAppointmentByDateModel;

  void indexAppointmentByDate({
    required String date,
  }) {
    emit(ApppintmentListByDateLoadingState());
    DioHelper.postData(
        url: 'indexAppointmentByDate',
        data: {
          'date': date,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      indexAppointmentByDateModel =
          IndexAppointmentByDateModel.fromJson(value.data);
      print(indexAppointmentByDateModel.appointment[0].status);
      print(indexAppointmentByDateModel.success);
      emit(ApppintmentListByDateSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(ApppintmentListByDateErrorState());
    });
  }

  late IndexApproveAppointmentByDateModel indexApproveAppointmentByDateModel;

  void indexApproveAppointmentByDate({
    required String date,
    required int doctor_id,
  })
  {
    emit(ApproveApppintmentListByDateLoadingState());
    DioHelper.postData(
        url: 'indexApproveAppointmentByDate',
        data: {
          'date': date,
          'doctor_id': doctor_id,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      indexApproveAppointmentByDateModel = IndexApproveAppointmentByDateModel.fromJson(value.data);
      print(indexApproveAppointmentByDateModel.appointment[0].status);
      print(indexApproveAppointmentByDateModel.success);
      emit(ApproveApppintmentListByDateSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(ApproveApppintmentListByDateErrorState());
    });
  }

  late IndexAppointmentDoctorModel indexAppointmentDoctorModel;

  void indexAppointmentDoctor({
    required int doctor_id,
  })
  {
    emit(AppointmentListDoctorLoadingState());
    DioHelper.postData(
        url: 'indexAppointmentDoctor',
        data: {
          'doctor_id': doctor_id,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      indexAppointmentDoctorModel = IndexAppointmentDoctorModel.fromJson(value.data);
      print(indexAppointmentDoctorModel.appointment[0].time);
      print(indexAppointmentDoctorModel.success);
      emit(AppointmentListDoctorSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(AppointmentListDoctorErrorState());
    });
  }

  late DateWaitingAppointmentModel dateWaitingAppointmentModel;

  void dateHaveWaitingAppointment()
  {
    emit(DateWaitingAppointmentLoadingState());
    DioHelper.postData(
        url: 'DateHaveAppointmentToHandel',
        data: {},
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      dateWaitingAppointmentModel = DateWaitingAppointmentModel.fromJson(value.data);
      print(dateWaitingAppointmentModel.message);
      print(dateWaitingAppointmentModel.success);
      emit(DateWaitingAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(DateWaitingAppointmentErrorState());
    });
  }

  late DateApproveAppointmentModel dateApproveAppointmentModel;

  void dateHaveApproveAppointment({
    required int doctor_id,
  })
  {
    emit(DateApproveAppointmentLoadingState());
    DioHelper.postData(
        url: 'indexApproveAppointment',
        data: {
          'doctor_id': doctor_id,
        },
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      dateApproveAppointmentModel = DateApproveAppointmentModel.fromJson(value.data);
      print(dateApproveAppointmentModel.message);
      print(dateApproveAppointmentModel.appointment[0].date);
      emit(DateApproveAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(DateApproveAppointmentErrorState());
    });
  }

  late ViewInfoHandleModel viewInfoHandleModel;

  void viewInfoHandle({
    required int id,
  })
  {
    emit(ViewInfoHandleLoadingState());
    DioHelper.getData(
        url: 'handled/view/$id',
        query: null,
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      viewInfoHandleModel = ViewInfoHandleModel.fromJson(value.data);
      print(value.toString());
      print(viewInfoHandleModel.appointment.doctor.consultationPrice);
      emit(ViewInfoHandleSuccssesState());
    }).catchError((error){
      print(error.toString());
      emit(ViewInfoHandleErrorState());
    });
  }

  late ApproveTheAppointmentModel approveTheAppointmentModel;

  void approveTheAppointment({
    required int id,
  })
  {
    emit(ApproveTheAppointmentLoadingState());
    DioHelper.postData(
        url: 'approveTheAppointment/$id',
        data: {},
        token: CacheHelper.getData(key: 'Token')
    ).then((value) {
      print(value.data);
      approveTheAppointmentModel =
          ApproveTheAppointmentModel.fromJson(value.data);
      print(approveTheAppointmentModel.message);
      print(approveTheAppointmentModel.success);
      emit(ApproveTheAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(ApproveTheAppointmentErrorState());
    });
  }

  late CancelAppointmentModel cancelAppointmentModel;

  void cancelAppointment({
    required String cancel_reason,
    required int id,
  })
  {
    emit(CancelAppointmentLoadingState());
    DioHelper.postData(
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
      emit(CancelAppointmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(CancelAppointmentErrorState());
    });
  }

  late DeleteAppointmentModel deleteAppointmentModel;

  void deleteAppointment({
    required int id,
  })
  {
    emit(DeleteAppointmentLoadingState());
    DioHelper.postData(
        url: 'deleteAppointment',
        data: {
          'id': id,
        },
        token: Constants.patientToken
    ).then((value) {
      print(value.data);
      deleteAppointmentModel = DeleteAppointmentModel.fromJson(value.data);
      print(deleteAppointmentModel.message);
      print(deleteAppointmentModel.success);
      if(deleteAppointmentModel.success)
      {
        emit(DeleteAppointmentSuccssesState());
      }else{
        emit(DeleteAppointmentErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(DeleteAppointmentErrorState());
    });
  }

  late HandelApppintmentModel handelApppintmentModel;

  void handelApppintment({
    required String date,
    required String time,
    required String status,
    required int id,
  }) {
    emit(HandelApppintmentLoadingState());
    DioHelper.postData(
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

  /*late IndexDoctorModel indexDoctorModel;

  void indexDoctor()
  {
    emit(DoctorListLoadingState());
    DioHelperG.getDataG(
        url: 'indexDoctor',
        query: null,
        token: Constants.adminToken
    ).then((value) {
      indexDoctorModel = IndexDoctorModel.fromJson(value.data);
      print(value.toString());
      print(indexDoctorModel!.doctor[0].user.firstName);
      emit(DoctorListSuccssesState());
    }).catchError((error){
      print(error.toString());
      emit(DoctorListErrorState());
    });
  }
  */

  late ViewDoctorModel viewDoctorModel;

  void viewDoctor({
    required int user_id,
  }) {
    emit(DoctorProfLoadingState());
    DioHelper.postData(
        url: 'viewDoctor',
        data: {
          'user_id': user_id,
        },
        token: Constants.adminToken
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

  late IndexDoctorByDepartmentModel indexDoctorByDepartmentModel;

  void indexDoctorByDepartment({
    required int department_id,
  })
  {
    emit(DoctorListByDepartmentLoadingState());
    DioHelper.postData(
        url: 'doctors/indexByDepartment',
        data: {
          'department_id': department_id,
        },
        token: Constants.adminToken
    ).then((value) {
      print(value.data);
      indexDoctorByDepartmentModel = IndexDoctorByDepartmentModel.fromJson(value.data);
      print(indexDoctorByDepartmentModel.doctor[0].description);
      print(indexDoctorByDepartmentModel.success);
      emit(DoctorListByDepartmentSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(DoctorListByDepartmentErrorState());
    });
  }


  /*IndexMyTimeModel? indexMyTimeModel;

  void indexMyTime()
  {
    emit(WorkTimeListLoadingState());
    DioHelperG.getDataG(
        url: 'indexMyTime',























        query: null,
        token: Constants.doctorToken
    ).then((value) {
      indexMyTimeModel = IndexMyTimeModel.fromJson(value.data);
      print(value.toString());
      print(indexMyTimeModel!.workDay[0].day);
      emit(WorkTimeListSuccssesState());
    }).catchError((error){
      print(error.toString());
      emit(WorkTimeListErrorState());
    });
  }*/

  late ViewSecretaryModel viewSecretaryModel;

  void viewSecretary({
    required int user_id,
  })
  {
    emit(SecretariaProfLoadingState());
    DioHelper.postData(
        url: 'viewSecretary',
        data: {
          'user_id': user_id,
        },
        token: Constants.adminToken
    ).then((value) {
      print(value.data);
      viewSecretaryModel = ViewSecretaryModel.fromJson(value.data);
      print(viewSecretaryModel.message);
      print(viewSecretaryModel.secretary.user.firstName);
      emit(SecretariaProfSuccssesState());
    }).catchError((error) {
      print(error.toString());
      emit(SecretariaProfErrorState());
    });
  }

  Map<String, dynamic> decode(String token) {
    final splitToken = token.split("."); // Split the token by '.'
    if (splitToken.length != 3) {
      throw FormatException('Invalid token');
    }
    try {
      final payloadBase64 = splitToken[1]; // Payload is always the index 1
      // Base64 should be multiple of 4. Normalize the payload before decode it
      final normalizedPayload = base64.normalize(payloadBase64);
      // Decode payload, the result is a String
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      // Parse the String to a Map<String, dynamic>
      final decodedPayload = jsonDecode(payloadString);

      perInfo = decodedPayload;
      print(payloadString);
      // Return the decoded payload
      return decodedPayload;
    } catch (error) {
      throw const FormatException('Invalid payload');
    }
  }

  int getMyId(){

    perInfo = decode(CacheHelper.getData(key: 'Token'));

    return int.parse(perInfo!['sub']);
  }
}