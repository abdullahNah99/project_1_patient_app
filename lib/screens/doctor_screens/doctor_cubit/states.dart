abstract class DoctorStates{}
 class DoctorHomeInitialState extends DoctorStates {}

 class DoctorHomeLoadingState extends DoctorStates {}
 class DoctorHomeSussesState extends DoctorStates {}
 class DoctorHomeErrorState extends DoctorStates
 {
  final String error;
  DoctorHomeErrorState({required this.error});
 }
 class DoctorHomeLogOutState extends DoctorStates {}
 class DoctorHomeChangeBottomNavState extends DoctorStates {}



class DoctorInfoLoadingState extends DoctorStates {}
class DoctorGetInfoSussesState extends DoctorStates {}
class DoctorGetInfoErrorState extends DoctorStates
{
 final String error;
 DoctorGetInfoErrorState({required this.error});
}


class DoctorViewAppointmentLoadingState extends DoctorStates {}
class DoctorViewAppointmentSussesState extends DoctorStates {}
class DoctorViewAppointmentErrorState extends DoctorStates
{
 final String error;
 DoctorViewAppointmentErrorState({required this.error});
}