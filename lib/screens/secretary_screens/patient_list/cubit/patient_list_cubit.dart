/*
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/dio_helper.dart';
import '../../../../core/models/secretaria/secretaria_patient/index_patient_model.dart';
import 'patient_list_states.dart';

class PatientListCubit extends Cubit<PatientListStates>
{
  PatientListCubit() : super(PatientListInitialStates());

  static PatientListCubit get(context) => BlocProvider.of(context);

  final String adminToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTY1ODg0YWYxZjljZjY1NDliNjNlZjUyNzc1MTIxMjA3YzgzMWZjZDk2MThlMDQxMTkxOWYxYWU1MzdiZmI5N2UxZTg0YjZjZTgwMTUyOGMiLCJpYXQiOjE2OTA0NDQ3MTUuMjA4NDE0LCJuYmYiOjE2OTA0NDQ3MTUuMjA4NDI2LCJleHAiOjE3MjIwNjcxMTUuMTU4NzUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.CSWWRbgdUuR6LsFS7_E5xItpJXgIb2YQBMHhFkN8z-QJX1Cxjcos_OARGjAE_goEUPQrhlZydByMWPil2EqsfWzVMPZfVdPtnVK7eM95IkGavjQOzYealEIPzcxWRr0BPfMzzEvAHJLO-rFILF8om9r9x1MHW6luvfPbMBbmqFVPrOr7LkNH_UBz5N3Xk9O2Zof7YubWeHscmY8y7JcUkzCF8Ddojr9ZiDXsabUkPvL7R39BYUR8isFZeB8InMFcz54QBXGQWIE_2SUMgkGLNc_OEDeMxpFF_JuDsOlGZu2FStPzDb0KJ1mxzgTsMYtevQAAKSMWarUlY6dqCxXNKYpQ5p-957UDN2BFfrBTWWjfc8kg-HnIpWbqnMkOnu0Cc3T9ON4H18gUNNm1Ugi0mEDOMclkBYn3jpX5Z2CkhxOvJ8yyMHFTJZ5iqdLVUHAsdtWTkmLnDMLInBFYgMuFLE70F7hZ5sZrKYk_8NTfHvmnHPHxI65SQVLtn3BTtp2voxsFj4Fi7nFivD63O-CS3XH02aCWCdE8h5g9a34shfyIq0F85farPS-O56bonmADp8TGBadSyf0-b3HSURPrMtOGxeXRWeWr_R9G-YoXE0nDuJ_VY--1p1afjkkob8wE5LsOAQAWDdp4iElHkZnyHIhirxnTO64DjQa2XFk8oJ8';

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
