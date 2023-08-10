import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/core/api/services/get_doctor_info.dart';
import 'package:patient_app/core/models/doctor_info_model.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consult_doctor_cubit/states.dart';
import '../../../../core/api/dio_api_services.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/models/index_consult_by_doctor_model.dart';

class DoctorConsultCubit extends Cubit<DoctorConsultStates>
{

  DoctorConsultCubit() : super(DoctorConsultInitialState());
  static DoctorConsultCubit get(context) =>BlocProvider.of(context);






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


  DoctorInfoModel? doctorInfoModel;

/*
  Future<void> fetchMyId() async {
    emit(DoctorInfoLoadingState());
    String token = await CacheHelper.getData(key: 'Token');
    int id = int.parse(JwtDecoder.decode(token)['sub']);

    (await GetDoctorIdService.getId(id: id)).fold(
          (failure) {
        emit(DoctorGetInfoErrorState(error: failure.errorMessege));
      },
          (doctorInfoModel) async {
        this.doctorInfoModel = doctorInfoModel;

        // await getDoctors();
      },
    );
    print(id);

  }
*/





  late IndexConsultByDoctorModel indexConsultByDoctorModel;
  void getQuestion()
  {
    emit(DoctorConsultGetQuestionLoadingState());
    DioHelper.getData(
      url: 'consultation/index',
      token: CacheHelper.getData(key: 'Token'),
    ).then((value)
    {
      indexConsultByDoctorModel =IndexConsultByDoctorModel.fromJson(value.data);
      print(indexConsultByDoctorModel.message);
      print(indexConsultByDoctorModel.consultaion[0].question);

      emit(DoctorConsultGetQuestionSuccessState());

    }).catchError((error)
    {
      emit(DoctorConsultGetQuestionErrorState(error: error.toString()));
    });
  }


  void postAnswer({
    required String answer,
   //required int id,
  }) async
  {
    emit(DoctorConsultPostAnswerLoadingState());
    DioHelper.postData(
        url: 'answer/store/3',
        token: await CacheHelper.getData(key:'Token'),
        data:
        {
          'answer': answer,
        }
    ).then((value)
    {

      indexConsultByDoctorModel = IndexConsultByDoctorModel.fromJson(value.data);
      print(getMyId().toString());
      emit(DoctorConsultPostAnswerSuccessState());

    }).catchError((error)
    {
      emit(DoctorConsultPostAnswerErrorState(error: error.toString()));

    });
  }

}