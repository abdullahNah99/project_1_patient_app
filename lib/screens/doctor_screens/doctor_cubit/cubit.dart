import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/screens/doctor_screens/doctor_cubit/states.dart';

class DoctorSessionsCubit extends Cubit<DoctorSessionsStates>
{
  DoctorSessionsCubit() : super(DoctorSessionsInitialState());
  static DoctorSessionsCubit get(context) =>BlocProvider.of(context);

}