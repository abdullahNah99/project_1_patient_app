import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/api/services/consultation/send_answer_service.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consult_doctor_cubit/states.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/services/get_doctor_details_service.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/functions/custome_snack_bar.dart';
import '../../../../core/models/consultation_model.dart';
import '../../../../core/models/index_consult_by_doctor_model.dart';


class DoctorConsultCubit extends Cubit<DoctorConsultStates>
{
  DoctorConsultCubit() : super(DoctorConsultInitialState());
  static DoctorConsultCubit get(context) =>BlocProvider.of(context);

  ConsultationModel? consultationModel;



  Map<String, dynamic>? perInfo;
  Map<String, dynamic> decode(String token) {
    final splitToken = token.split("."); // Split the token by '.'
    if (splitToken.length != 3) {
      throw const FormatException('Invalid token');
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

  int getMyId() {
    String token = CacheHelper.getData(key: 'Token');
    perInfo = decode(token);
    return int.parse(perInfo!['sub']);
  }

  //DoctorInfoModel? doctorInfoModel;

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
  void getQuestion() {
    emit(DoctorConsultGetQuestionLoadingState());
    DioHelper.getData(
      url: 'consultation/index',
      token: CacheHelper.getData(key: 'Token'),
      query: null,
    ).then((value) {
      indexConsultByDoctorModel =IndexConsultByDoctorModel.fromJson(value.data);
      print(indexConsultByDoctorModel.message);
      print(indexConsultByDoctorModel.consultaion[0].question);

      emit(DoctorConsultGetQuestionSuccessState());
    }).catchError((error) {
      emit(DoctorConsultGetQuestionErrorState(error: error.toString()));
    });
  }



  Future<void> addAnswer(
      BuildContext context,
      {
        required int consultationID,
        required String answer,
      }) async {
    emit(DoctorConsultPostAnswerLoadingState());
    (await SendAnswerService.sendAnswer(
      consultationID: consultationID ,
      answer: answer,
      token: CacheHelper.getData(key: 'Token'),
    )
    )
        .fold(
          (failure) {
        //Navigator.pop(context);
        emit(DoctorConsultPostAnswerFinishState());
         //emit(DoctorConsultPostAnswerErrorState(error: failure.errorMessege));
        CustomeSnackBar.showSnackBar(
          context,
          msg: 'Error occurred, Please Try Later',
          color: Colors.red,
        );
      },
          (consultationModel)
           {
               this.consultationModel =consultationModel;
                //Navigator.pop(context);
                  emit(DoctorConsultPostAnswerFinishState());

                 CustomeSnackBar.showSnackBar(
                  context,
                    msg: 'Answer Send Successfully',
                    color: Colors.black38,
                    );
               emit(DoctorConsultPostAnswerSuccessState());
             //Navigator.pop(context);
      },
    );

  }


 /* void postAnswer({
    required String answer,
    //required int id,
  }) async {
    emit(DoctorConsultPostAnswerLoadingState());
    DioHelper.postData(
        url: 'answer/store/3',
        token: await CacheHelper.getData(key: 'Token'),
        data: {
          'answer': answer,
        }).then((value) {
      indexConsultByDoctorModel = IndexConsultByDoctorModel.fromJson(value.data);
      //print(getMyId().toString());
      emit(DoctorConsultPostAnswerSuccessState());
    }).catchError((error) {
      emit(DoctorConsultPostAnswerErrorState(error: error.toString()));
    });

  }


*/

}