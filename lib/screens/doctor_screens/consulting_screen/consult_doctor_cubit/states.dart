import '../../../../core/models/consultation_model.dart';
import '../../../../core/models/doctor_model.dart';

abstract class  DoctorConsultStates{}
 class DoctorConsultInitialState  extends  DoctorConsultStates{}
 class DoctorConsultChangeState  extends  DoctorConsultStates{}


class DoctorConsultGetQuestionLoadingState extends DoctorConsultStates {}
class DoctorConsultGetQuestionSuccessState extends DoctorConsultStates {}
class DoctorConsultGetQuestionErrorState extends DoctorConsultStates
{
  final String error;
  DoctorConsultGetQuestionErrorState({required this.error});
}
class DoctorConsultPostAnswerLoadingState extends DoctorConsultStates {}
class DoctorConsultPostAnswerSuccessState extends DoctorConsultStates {}
class DoctorConsultPostAnswerErrorState extends DoctorConsultStates
{
  final String error;
  DoctorConsultPostAnswerErrorState({required this.error});
}
class DoctorConsultPostAnswerFinishState extends DoctorConsultStates {}



class DoctorConsultGetInitialState extends DoctorConsultStates {}
class DoctorConsultGetLoadingState extends DoctorConsultStates {}
class DoctorConsultGetSuccessState extends DoctorConsultStates {
  final ConsultationModel consultationModel;
  DoctorConsultGetSuccessState({required this.consultationModel});
}
class DoctorConsultGetErrorState extends DoctorConsultStates
{
  final String error;
  DoctorConsultGetErrorState({required this.error});
}


