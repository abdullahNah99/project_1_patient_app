import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/core/api/services/dio_api_services.dart';
import 'package:patient_app/core/models/doctor_info_model.dart';
import 'package:patient_app/core/models/index_appointment_by_doctor_model.dart';
import 'package:patient_app/screens/doctor_screens/appointment_screen/appointment_screen.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consulting_screen.dart';
import 'package:patient_app/screens/doctor_screens/home_doctor_screen/home_doctor_cubit/states.dart';
import 'package:patient_app/screens/doctor_screens/search_screen/search_screen.dart';
import 'package:patient_app/screens/doctor_screens/session_screen/session_screen.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import '../../../../core/api/services/get_doctor_info.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/api/services/local/end_point.dart';
import '../../../../core/api/services/log_out_service.dart';
import '../../../../core/models/index_consult_by_doctor_model.dart';

class DoctorCubit extends Cubit<DoctorStates>
{
  DoctorCubit() : super(DoctorHomeInitialState());
  static DoctorCubit get(context) =>BlocProvider.of(context);
  final String _adminToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjY5MzI3ZTEwNDI3NGRmMzE1YzE2NmVlMjAzNDIxNjRkZWIzNzcwNzdlZjM0MDY0MmYzNjFlZDQ0ZTE0Mzg2MDRiYmE5NzczZTkzYTFiZjYiLCJpYXQiOjE2OTE1ODUzMTYuNzc3NTc5LCJuYmYiOjE2OTE1ODUzMTYuNzc3NTgyLCJleHAiOjE3MjMyMDc3MTYuNzY3ODg5LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.mqMrUix6vASVF8PF-ISzjGjFIY8ce-raRhCncnrslJkoClOF62tfUnPuMqLwqGdYv6_ex5vDFavPoDqcYL4Ks9JK72n3GQ2xLMkQF1vnhM7ut6j6kgDQ7kWHGldhT1cyFxe9rNiw6Ixl3-7l88r_BC-Ee2y3nsG1AUmCwC2v8MTvJNNsCq_PcD5rAHI7zgIJQWuCWY5Q_e6_a-qST2DtWwPE9_EIdFXJuxvsbg0aQnTVQKfrya3TYuTfH6R5Bwit4JXR7PUzJeVHHMK5K5F0uLdfOcxrM_Jeeygg5DBdJlvBSP6GtvFqx1zTJBOOXMXXEuNvyYadcw6yehwJ8QcG3hr_tsK48HxeCH8W-dpUusLsZ8guu6-cqzQzOsopMFD7Ves0NUYzAqRWBjAEm0kLH8DdMTdCiG3WlVHl3Z_omglKtkl9sXejERAnveII1ZHv0WTlSVLL_IgO-2hkkeiJKLHK4EjKV5Wh03SNJGBEKswOZ9FkkZUtYJWgO86LSf5V2D_Hp05MhlYgwAHy4HxEuz0y9x5nzfZgvK3YNKOFPKhLcdcjOVBjirFLz61HcB1yg3_7wmyXuW5qzo0B2MRIK5IKByPaJYSklrRPsuC1MgYNhwAqsovu5VGYWeXyWUJfJXEN-LsFnL-uGeuhEV0sO4IvPo7UyN5nmyi9oJCAkNI'
 ;


  int currentIndex = 0;
  List<Widget> bottomNavScreens =
  [
      ShowAppointmentScreen(),
      ShowConsultingScreen(),
      ShowSessionScreen(),
      SearchScreen(),
  ];

  List <BottomNavigationBarItem> items =const
  [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.date_range_rounded,
        size: 25.0,),
      label: 'Appointment',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.question_answer_outlined,
        size: 25.0,),
      label: 'Consulting',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.medical_information_outlined,
        size: 25.0,),
      label: 'Session',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined,
        size: 25.0,),
      label: 'Search',
    ),
  ];

  void changeBottomNav(int index)
  {
    currentIndex = index;
    emit(DoctorHomeChangeBottomNavState());

  }

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


  DoctorInfoModel? doctorInfoModel;

  Future<void> fetchMyInfo() async {
    emit(DoctorInfoLoadingState());
    String token = await CacheHelper.getData(key: 'Token');
    int userID = int.parse(JwtDecoder.decode(token)['sub']);

    (await GetDoctorInfoService.getMyInfo(userID: userID)).fold(
          (failure) {
        emit(DoctorGetInfoErrorState(error: failure.errorMessege));
      },
          (doctorInfoModel) async {
        this.doctorInfoModel = doctorInfoModel;

       // await getDoctors();
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

  int getMyId(){
    String token = CacheHelper.getData(key: 'Token');
    perInfo = decode(token);
    return int.parse(perInfo!['sub']);
  }



 late IndexAppointmentByDoctorModel indexAppointmentByDoctorModel;

Future<void> viewAppointment({required int doctor_id})
  async {
  emit(DoctorViewAppointmentLoadingState());
  DioHelper.postData(
      url: 'indexAppointmentDoctor',
      token: await CacheHelper.getData(key:'Token'),
      data: {
        'doctor_id': doctor_id,
      }
  ).then((value)
  {
    indexAppointmentByDoctorModel = IndexAppointmentByDoctorModel.fromJson(value.data);
    emit(DoctorViewAppointmentSussesState());
    print(indexAppointmentByDoctorModel.message);
  }).catchError((error)
  {
    emit(DoctorViewAppointmentErrorState(error: error.toString()));
  });

}













}