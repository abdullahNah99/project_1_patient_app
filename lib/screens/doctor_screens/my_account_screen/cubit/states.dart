import 'package:patient_app/core/models/doctor_model.dart';

abstract class MyAccountStates{}
class MyAccountInitialState extends MyAccountStates {}
class MyAccountLoadingState extends MyAccountStates {}
class MyAccountSussesState extends MyAccountStates
{
  final DoctorModel  model;
  MyAccountSussesState({required this.model});

}
class MyAccountErrorState extends MyAccountStates
{
  final String error;
  MyAccountErrorState({required this.error});
}