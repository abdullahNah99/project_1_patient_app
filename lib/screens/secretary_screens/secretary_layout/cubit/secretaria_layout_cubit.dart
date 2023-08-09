/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/services/local/cache_helper.dart';
import '../../appointments_requests_screen/appointments_requests_view.dart';
import '../../patient_list/patient_list.dart';
import 'secretaria_layout_states.dart';

class SecretariaLyoutCubit extends Cubit<SecretariaLyoutStates>
{
  SecretariaLyoutCubit() : super(SecretariaLyoutInitialStates());

  static SecretariaLyoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Patient',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.calendar_month_sharp,
      ),
      label: 'Appointment',
    ),
  ];

  List<Widget> page = [
    const PatientList(),
    AppointmentsRequestsView(token: CacheHelper.getData(key: 'Token')),
  ];

  void changBottomNavBar(int index){
    currentIndex = index;
    emit(SecretariaLyoutChangeNavBarStates());
    */
/*if(Index == 0){
      getBusniessData();
    }
    if(Index == 1){
      getSportsData();
    }
    if(Index == 2){
      getScienceData();
    }*//*

  }
}*/
