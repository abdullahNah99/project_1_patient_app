/*
import '../../../../core/models/appointment_model.dart';
import '../../../../core/models/work_day_model.dart';

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
*/

/*
import '../../../../core/models/appointment_model.dart';
abstract class DoctorAppointmentStates{}
class DoctorAppointmentInitialState extends DoctorAppointmentStates{}

class DoctorAppointmentLoadingState extends DoctorAppointmentStates{}
class DoctorAppointmentSuccessState extends DoctorAppointmentStates
{
  final List<AppointmentModel> appointment;

  DoctorAppointmentSuccessState({
    required this.appointment,
  });
}
class DoctorAppointmentErrorState extends DoctorAppointmentStates{
  final String error;
  DoctorAppointmentErrorState({required this.error});

}


*/

part of 'home_cubit.dart';

abstract class DoctorStates extends Equatable {
  const DoctorStates();

  @override
  List<Object> get props => [];
}

class DoctorHomeInitialState extends DoctorStates {}

class DoctorHomeLoadingState extends DoctorStates {}

class DoctorHomeSussesState extends DoctorStates {}

class DoctorHomeErrorState extends DoctorStates {
  final String error;
  const DoctorHomeErrorState({required this.error});
}

class DoctorHomeLogOutState extends DoctorStates {}

class DoctorHomeChangeBottomNavState extends DoctorStates {}

class DoctorInfoLoadingState extends DoctorStates {}

class DoctorGetInfoSussesState extends DoctorStates {}

class DoctorGetInfoErrorState extends DoctorStates {
  final String error;
  const DoctorGetInfoErrorState({required this.error});
}

class DoctorViewAppointmentLoadingState extends DoctorStates {}

class DoctorViewAppointmentErrorState extends DoctorStates {
  final String error;

  const DoctorViewAppointmentErrorState({required this.error});
}

class DoctorViewAppointmentSuccessState extends DoctorStates {
  final List<AppModel> appointments;
  const DoctorViewAppointmentSuccessState({required this.appointments});
}

class GetPatientsLoadingState extends DoctorStates {}

class GetPatientsErrorState extends DoctorStates {
  final String error;
  const GetPatientsErrorState({required this.error});
}

class GetPatientsSuccessState extends DoctorStates {
  final List<PatientModel> patient;
  const GetPatientsSuccessState({required this.patient});
}

/*
class GetPatientAndSessionSuccess extends DoctorStates {
 final List<PatientModel> patients;
 final List<SessionModel> session;

 GetPatientAndSessionSuccess({
  required this.patients,
  required this.session,
 });

 List<SessionModel> getSessionDoctors(
     {int? patientID}) {
  List<SessionModel> session = [];
  if (patientID != null) {
   for (SessionModel item in this.session) {
    if (item.session.id == patientID) {

     session.add(item);
    }
   }
   return session;
  }
  return session;
 }
}

*/

class GetSessionLoadingState extends DoctorStates {}

class GetSessionErrorState extends DoctorStates {
  final String error;
  const GetSessionErrorState({required this.error});
}

class GetSessionSuccessState extends DoctorStates {
  final List<SessionModel> session;
  const GetSessionSuccessState({required this.session});
}

class SearchLoadingState extends DoctorStates {}

class SearchErrorState extends DoctorStates
{
 final String error;
 SearchErrorState({required this.error});
}
class SearchSuccessState extends DoctorStates {
  final List<UsersModel> users;

  const SearchSuccessState({required this.users});
}
