import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/core/api/services/dio_api_services.dart';
import 'package:patient_app/core/models/doctor_info_model.dart';
import 'package:patient_app/core/models/index_appointment_by_doctor_model.dart';
import 'package:patient_app/screens/doctor_screens/appointment_screen/appointment_screen.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consulting_screen.dart';
import 'package:patient_app/screens/doctor_screens/doctor_cubit/states.dart';
import 'package:patient_app/screens/doctor_screens/search_screen/search_screen.dart';
import 'package:patient_app/screens/doctor_screens/session_screen/session_screen.dart';
import 'package:patient_app/screens/login_screen/login_screen.dart';
import '../../../core/api/services/get_doctor_info.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/api/services/local/end_point.dart';
import '../../../core/api/services/log_out_service.dart';

class DoctorCubit extends Cubit<DoctorStates>
{
  DoctorCubit() : super(DoctorHomeInitialState());
  static DoctorCubit get(context) =>BlocProvider.of(context);

  final String _adminToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZmY0ZWMxZThhZDljNmY4ZmVmYzNlYzgxOWIxZjQ2OTM3NWI4OWQ1ZTc1NmJlYjBlZTNlNmM1Zjg3OTQ5NjhhMjc5MDE0YzQ5MTY5ZjkxYjEiLCJpYXQiOjE2OTE0NzM1MzYuNTc0ODI1LCJuYmYiOjE2OTE0NzM1MzYuNTc0ODMsImV4cCI6MTcyMzA5NTkzNi41NTc4OTUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.xoJ-WhdrIJVGrWYmU7PlHbuC6sGs59LWw3vuwD-ywlS-xX2U2pDV27zNy1bLinaAk771W9wFyKFG4fACmmdsXfr3oshVrdWI7Rs4tfpHmtR5lAQ6aohIQJg9qeeWEUOWzWcI9R9L2Kv_q6UWV_eGyne2_zJCy728rMP2k3Vw_UYdv4SgfJhErmfia9MNJzb3d48SZRYyqGFIB61uXLG33trOCYOvO_oKnyxpGls5mNZ0Ep6I-3yYPFwlM9YDcX4BTVWVvx1c8Tje6cbLBdXy_MaQAsf8SHdra7XEK6Zb8TJhLjnwuEwbQL8RBNtxi_PPIG0hYDaczUKZXaO3iDmvwQKTnqMZsYI9H1SddXuJOJgnc9Ppzl-4NXLxJTWjwYjVuQxne3t0DAqNaZoC_0E5ut8K5HZ0pd3A4UyOZL2E0gojkMQXaoY9YKfueCQlhTHZ3aYT7Gawgc_2_X9ujGNQNsDa-1rvQSJLE40-1xwITVTS5pq-Tm945rHZibhWxfq0Wt0sZ4kpmS9RULTt3hKpbgDfgQSqroXBMFkWINSQ1_FF4aLTjc1_mxADp1qOauYDPY34zdGB0UhCzatPdMNVWu7nG_paMcmQIKVMdg2JkKyH4jMVV40rAB9yqLjeyVKe9z3u0v58XxLJGg9uvk7bdB_XoFTz4JDp7gHBadJqLgA';
 // DoctorInfoModel? doctorInfoModel;

  int currentIndex = 0;
  List<Widget> bottomNavScreens =
  [
      ShowAppointmentScreen(),
      ShowSessionScreen(),
      ShowConsultingScreen(),
      SearchScreen(),
  ];

  List <BottomNavigationBarItem> items =
  [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.date_range_rounded,
        size: 25.0,),
      label: 'Appointment',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.medical_information_outlined,
        size: 25.0,),
      label: 'Session',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.question_answer_outlined,
        size: 25.0,),
      label: 'Consulting',
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

///////////////
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
    String token =  CacheHelper.getData(key: 'Token');
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