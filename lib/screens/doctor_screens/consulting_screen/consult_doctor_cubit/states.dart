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



class DoctorConsultGetInfoInitialState extends DoctorConsultStates {}
class DoctorConsultGetInfoLoadingState extends DoctorConsultStates {}
class DoctorConsultGetInfoSuccessState extends DoctorConsultStates {
  final DoctorModel doctorModel;
  DoctorConsultGetInfoSuccessState({required this.doctorModel});
}
class DoctorConsultGetInfoErrorState extends DoctorConsultStates
{
  final String error;
  DoctorConsultGetInfoErrorState({required this.error});
}

