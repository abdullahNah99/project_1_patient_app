import 'package:flutter/material.dart';
import 'package:patient_app/screens/doctor_screens/home_doctor_screen/home_doctor_screen.dart';
import 'package:patient_app/screens/patient_screens/favourite_screen/favourite_screen.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../screens/patient_screens/add_appointment_view/add_appointment_view.dart';
import '../../screens/patient_screens/doctor_details_screen/doctor_details_screen.dart';
import '../../screens/patient_screens/home_patient_screen/home_patient_screen.dart';
import '../../screens/patient_screens/show_all_consultation/show_all_consultation.dart';
import '../../screens/register_screen/register_screen.dart';
import '../../screens/secretary_screens/add_patient/add_patient.dart';
import '../../screens/secretary_screens/appointments_requests_screen/appointments_requests_view.dart';
import '../../screens/secretary_screens/secretary_layout/secretaria_latout.dart';
import '../api/services/local/cache_helper.dart';

abstract class AppRouter {
  static final router = <String, WidgetBuilder>{
    LoginView.route: (context) => const LoginView(),
    RegisterView.route: (context) => const RegisterView(),
    AddAppointmentView.route: (context) => const AddAppointmentView(),
    HomePatientView.route: (context) => const HomePatientView(),
    DoctorDetailsView.route: (context) => const DoctorDetailsView(),
    FavouriteView.route: (context) => const FavouriteView(),
    AppointmentsRequestsView.route: (context) =>
        AppointmentsRequestsView(token: CacheHelper.getData(key: 'Token')),
    ShowAllConsultationView.route: (context) => const ShowAllConsultationView(),
    SecretariaLayout.route: (context) => SecretariaLayout(),
    //PatientProfile.route: (context) => const PatientProfile(),
    RegisterSecretaria.route: (context) => RegisterSecretaria(),

    DoctorHomeScreen.route: (context) => DoctorHomeScreen(token: CacheHelper.getData(key: 'Token')),
  };
}
