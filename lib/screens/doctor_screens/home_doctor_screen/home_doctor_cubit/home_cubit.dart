import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/screens/doctor_screens/appointment_screen/appointment_screen.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consulting_screen.dart';
import 'package:patient_app/screens/doctor_screens/search_screen/search_screen.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import '../../../../core/api/services/appointment/get_doctor_appointments_service.dart';
import '../../../../core/api/services/get_doctor_information.dart';
import '../../../../core/api/services/get_patient_service.dart';
import '../../../../core/api/services/get_session_service.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/api/services/log_out_service.dart';
import '../../../../core/api/services/search_on_patient_services.dart';
import '../../../../core/functions/custome_snack_bar.dart';
import '../../../../core/models/app_model.dart';
import '../../../../core/models/doctor_model.dart';
import '../../../../core/models/patient_model.dart';
import '../../../../core/models/search_model.dart';
import '../../../../core/models/session_model.dart';
import '../../patients_session_screen/patients_screen.dart';
part 'home_states.dart';

class DoctorCubit extends Cubit<DoctorStates> {
  DoctorCubit() : super(DoctorHomeInitialState());
  static DoctorCubit get(context) => BlocProvider.of(context);
  DoctorModel? doctorModel;
  //PatientModel? patientModel;
  PatientModel patientModel = PatientModel();


  int currentIndex = 0;
  List<Widget> bottomNavScreens = [
    ShowAppointmentScreen(),
    ShowConsultingScreen(),
     ShowPatientsAndSessionScreen(),
    SearchScreen(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.date_range_rounded,
        size: 25.0,
      ),
      label: 'Appointment',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.question_answer_outlined,
        size: 25.0,
      ),
      label: 'Consulting',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 25.0,
      ),
      label: 'Patients',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.search_outlined,
        size: 25.0,
      ),
      label: 'Search',
    ),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(DoctorHomeChangeBottomNavState());
    if (index == 0) {
      getMyApp(doctorID: doctorModel!.id);
    }
    if (index == 2) {
      getPatients(token: CacheHelper.getData(key: 'Token'));
     // getSession(token:CacheHelper.getData(key: 'Token'), patientId: patientModel.id!);
    }
  }

  Future<void> logout(BuildContext context) async {
    emit(DoctorHomeLoadingState());
    (await LogOutService.logout(token: await CacheHelper.getData(key: 'Token')))
        .fold(
      (error) {
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

  Future<void> fetchMyInfo() async {
    emit(DoctorInfoLoadingState());
    String token = await CacheHelper.getData(key: 'Token');
    int userID = int.parse(JwtDecoder.decode(token)['sub']);
    (await GetDoctorInformationService.getUserInfo(userID: userID)).fold(
      (failure) {
        emit(DoctorGetInfoErrorState(error: failure.errorMessege));
      },
      (doctorModel) async {
        this.doctorModel = doctorModel;
      },
    );
    print(userID);
  }

  Map<String, dynamic>? perInfo;
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
      // Return the decoded payload
      return decodedPayload;
    } catch (error) {
      throw const FormatException('Invalid payload');
    }
  }

  int getMyId2() {
    String token = CacheHelper.getData(key: 'Token');
    perInfo = decode(token);
    return int.parse(perInfo!['sub']);
  }

  Future<void> getMyApp({required int doctorID}) async {
    emit(DoctorViewAppointmentLoadingState());
    (await GetDoctorAppointmentsService.getDoctorAppointments(
            token: CacheHelper.getData(key: 'Token'), doctorID: doctorID))
        .fold(
      (error) {
        emit(DoctorViewAppointmentErrorState(error: error.errorMessege));
      },
      (appointment) {
        emit(DoctorViewAppointmentSuccessState(appointments: appointment));
        print(appointment[0].date);
      },
    );
  }

  Future<void> getPatients({required String token}) async {
    emit(GetPatientsLoadingState());
    (await GetPatientService.getPatient(
      token: await CacheHelper.getData(key: 'Token'),
    ))
        .fold((error) {
      emit(GetPatientsErrorState(error: error.errorMessege));
    }, (patient) {
      emit(GetPatientsSuccessState(patient: patient));
    });
  }

  Future<void> getSession({required String token,required int patientId})
  async {
    emit(GetSessionLoadingState());
    (await GetSessionService.getSession(token: await CacheHelper.getData(key: 'Token'), patientId: patientId)).fold(
            (error) {
              emit(GetSessionErrorState(error: error.errorMessege));
            },
            (session) {
          emit(GetSessionSuccessState(session: session));
        }
    );
  }





  Future<void> search({required String name,required String token}) async
  {
    emit(SearchLoadingState());
    (await SearchOnPatientService.search(
        token: CacheHelper.getData(key: 'Token'),
        name:name,
    ))
        .fold(
          (error) {
        emit(SearchErrorState(error: error.errorMessege));
      },
          (users) {
       emit(SearchSuccessState(users:users));
        getPatients(token:CacheHelper.getData(key: 'Token'));
      },
    );
  }






/*


  Future<void> search({required String name,required String token}) async
  {
    emit(SearchLoadingState());
    (await SearchOnPatientService.search(
        token: CacheHelper.getData(key: 'Token'),
        name:name,
    ))
        .fold(
          (error) {
        emit(SearchErrorState(error: error.errorMessege));
      },
          (patients) {
       emit(SearchSuccessState(patient:patients));
        getPatients(token:CacheHelper.getData(key: 'Token'));
      //  print(patients[0].gender);
      },
    );
  }


*/

 /*late PatientModel patientModel;
  void search({required String token ,required String name})
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        token: CacheHelper.getData(key: 'Token') ,
        url: 'sessions/search',
        data: {
           'name':name,
        }).then((patient)
    {
     // patientModel = PatientModel.fromJson(value.data);
      emit(GetPatientsSuccessState( patient: patient));

    }).catchError((error)
    {
      emit(SearchErrorState(error:error.toString()));
    });

  }*/
}
