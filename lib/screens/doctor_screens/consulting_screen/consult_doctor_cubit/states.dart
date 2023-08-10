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


class DoctorInfoLoadingState extends DoctorConsultStates {}
class DoctorInfoSuccessState extends DoctorConsultStates {}
class DoctorGetInfoErrorState extends DoctorConsultStates
{
  final String error;
  DoctorGetInfoErrorState({required this.error});
}