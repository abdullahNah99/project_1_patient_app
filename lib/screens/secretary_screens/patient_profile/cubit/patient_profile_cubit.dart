/*
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/models/secretaria/secretaria_patient/view_patient_model.dart';
import 'patient_profile_states.dart';

class PatientProfCubit extends Cubit<PatientProfStates>
{
  PatientProfCubit() : super(PatientProfInitialStates());

  static PatientProfCubit get(context) => BlocProvider.of(context);


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
}*/
