/*
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/models/secretaria/secretaria_patient/index_patient_model.dart';
import 'patient_list_states.dart';

class PatientListCubit extends Cubit<PatientListStates>
{
  PatientListCubit() : super(PatientListInitialStates());

  static PatientListCubit get(context) => BlocProvider.of(context);


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
}*/
