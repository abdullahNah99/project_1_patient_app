import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/api/dio_helper.dart';
import 'package:patient_app/core/models/appointment_model.dart';
import 'package:http/http.dart' as http;
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/core/models/session_model.dart';
import 'package:patient_app/core/utils/constants.dart';
import '../../../../core/api/services/appointment/get_appointment_details.dart';
import '../../../../core/api/services/get_patient_service.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/functions/custome_snack_bar.dart';



part 'session_states.dart';
class SessionCubit extends Cubit<SessionStates> {
  SessionCubit() : super(SessionInitialState());

  static SessionCubit get(context) => BlocProvider.of(context);
 // static String baseUrl = 'http://192.168.1.10:8000/api/';

  List<PatientModel> patients = [];

  late AppointmentModel appointmentModel;
  late SessionModel sessionModel;

  Future<void> viewAppointment(
      {required int appointmentId, required String token}) async {
    emit(state);

    (await GetAppointmentDetailsService.getAppointmentDetails(
            token: await CacheHelper.getData(key: 'Token'), id: appointmentId))
        .fold((error) {
      emit(state);
    }, (success) {
      emit(state);
    });
  }

  ///////add session
  // File? departmentImage;
  var imageOfSession;
  final picker = ImagePicker();
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      imageOfSession = pickedFile.path;
      //File(pickedFile.path);
      print(imageOfSession.toString());
      emit(SessionImagePickedSuccessState());
    } else {
      print('no image selected.');
      emit(SessionImagePickedErrorState());
    }
  }

  Future<dynamic> postWithImage({
    required String endPoint,
    required Map<String, String> body,
    //required int appointmentId,
    @required String? imagePath,
    @required String? token,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Constants.baseURL}$endPoint'),
    );
    request.fields.addAll(body);
    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('img', imagePath));
    }
    request.headers.addAll(
      {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    http.StreamedResponse response = await request.send();

    http.Response r = await http.Response.fromStream(response);

    if (r.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(r.body);
      log('HTTP POSTIMAGE Data: $data');
      //getHomeDepData();
      return data;
    } else {
      throw Exception(
        'there is an error with status code ${r.statusCode} and with body : ${r.body}',
      );
    }
  }





  Future<void> getPatients(BuildContext context,{required String token}) async {
    emit(GetPatientsLoadingState());
    (await GetPatientService.getPatient(
      token: await CacheHelper.getData(key: 'Token'),
    ))
     .fold(
            (error)
        {
     // Navigator.pop(context);
         emit(GetPatientsErrorState(error: error.errorMessege));
         CustomeSnackBar.showSnackBar(
        context,
        msg: 'Error occurred, Please Try Later',
        color: Colors.red,
      );
       },
            (patients)
        {
        // Navigator.pop(context);
         emit(GetPatientsSuccessState(patients: patients));
         //GetPatientsSuccessState(patients: patients);
          CustomeSnackBar.showSnackBar(
          context,
          msg: 'Session Created Successfully..',
          color: Colors.black38,
      );

      print(patients[0].address);
    });
  }


 /// http://192.168.1.10:8000/api/sessions/patient/4



//session/delete/3
 void deleteSession({required String token,required int sessionId}) async
 {
   emit(SessionLoadingState());
   DioHelper.postData(url: 'session/delete/${sessionId}', data: null,token: await CacheHelper.getData(key: 'Token'),).then(
           (value)
       {
         sessionModel =SessionModel.fromJson(value.data);
         emit(SessionDeletedSuccessState());
         //getSession();
       }).catchError((error){
         emit(SessionDeletedErrorState(error: error));
   });
 }
 //session/update/2
 void updateSession({
   required String token,
   required String medicine,
   required String report,
   required String img,
   required int appointmentId,
   required int sessionId,}) async
 {
   emit(SessionLoadingState());
   DioHelper.postData(
        url: 'session/update/${sessionId}',
        data: {
          'medicine': medicine,
          'report': report,
          'img': img,
          'appointment_id': appointmentId,
        },
        token:await CacheHelper.getData(key: 'Token'),
        query:null  ).then(
           (value)
       {
         sessionModel =SessionModel.fromJson(value.data);
         emit(SessionUpdatedSuccessState());
       }).catchError((error)
   {
     emit(SessionUpdatedErrorState(error: error));
   });
 }


}
