abstract class DoctorStates{}
 class DoctorHomeInitialState extends DoctorStates {}
 class DoctorHomeChangeState extends DoctorStates {}


 class DoctorHomeLoadingState extends DoctorStates {}
 class DoctorHomeSussesState extends DoctorStates {}
 class DoctorHomeErrorState extends DoctorStates
 {
  final String error;
  DoctorHomeErrorState({required this.error});
 }
 class DoctorHomeLogOutState extends DoctorStates {}
