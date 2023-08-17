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

  late IndexConsultByDoctorModel indexConsultByDoctorModel;
  void getQuestion()
  {
    emit(DoctorConsultGetQuestionLoadingState());
    DioHelper.getData(
      url: 'consultation/index',
      token: CacheHelper.getData(key: 'Token'),
      query: null,
    ).then((value)
    {
      indexConsultByDoctorModel =IndexConsultByDoctorModel.fromJson(value.data);
      print(indexConsultByDoctorModel.consultaion[0].id);
      emit(DoctorConsultGetQuestionSuccessState());

    }).catchError((error)
    {
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
    (await SendAnswerService.sendAnswer(consultationID: consultationID , answer: answer, token: CacheHelper.getData(key: 'Token'),))
        .fold(
          (failure) {
            Navigator.pop(context);
            emit(DoctorConsultPostAnswerFinishState());
       // emit(DoctorConsultPostAnswerErrorState(error: failure.errorMessege));
        CustomeSnackBar.showSnackBar(
          context,
          msg: 'Error occurred, Please Try Later',
          color: Colors.red,
        );
      },
          (consultationModel)
      {
        this.consultationModel =consultationModel;
        Navigator.pop(context);
        emit(DoctorConsultPostAnswerFinishState());
        //emit(DoctorConsultPostAnswerSuccessState());
        CustomeSnackBar.showSnackBar(
          context,
          msg: 'Answer Send Successfully',
          color: Colors.black38,
        );

  },
    );

  }

}