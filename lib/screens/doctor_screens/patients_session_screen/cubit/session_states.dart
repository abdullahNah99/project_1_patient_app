
part of 'session_cubit.dart';

abstract class SessionStates extends Equatable
{
  const SessionStates();

  @override
  List<Object> get props => [];
}

//abstract class SessionStates {}

class SessionInitialState extends SessionStates {}

class SessionLoadingState extends SessionStates {}

class SessionSuccessState extends SessionStates {}

class SessionErrorState extends SessionStates {
  final String error;
   SessionErrorState({required this.error});
}


class SessionAddLoadState extends SessionStates {}
class SessionAddSuccessState extends SessionStates {}
class SessionAddErrorState extends SessionStates {
  final String error;
  SessionAddErrorState({required this.error});
}


class SessionImagePickedSuccessState extends SessionStates{}
class SessionImagePickedErrorState extends SessionStates{}



class GetPatientsLoadingState extends SessionStates{}
class GetPatientsErrorState extends SessionStates
{
  final String error;
  GetPatientsErrorState({required this.error});

}
class GetPatientsSuccessState extends SessionStates
{
  final List<PatientModel> patients;
  GetPatientsSuccessState({required this.patients});

}



class SessionDeletedSuccessState extends SessionStates{}
class SessionDeletedErrorState extends SessionStates
{
  final String error;
  SessionDeletedErrorState({required this.error});
}


class SessionUpdatedSuccessState extends SessionStates{}
class SessionUpdatedErrorState extends SessionStates{
  final String error;
  SessionUpdatedErrorState({required this.error});
}





