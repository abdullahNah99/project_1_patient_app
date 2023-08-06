
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_cubit.dart';

import '../api_cubit/api_states.dart';
import '../appointments_requests_screen/appointments_requests_view.dart';

class AppointmentsListDate extends StatelessWidget {

  int indexList = 0;
  List days = [
    //Tuesday Oct 08
    DateFormat.EEEE().format(DateTime.now()),
    DateFormat.EEEE().format(DateTime.now().add(const Duration(days: 1))),
    DateFormat.EEEE().format(DateTime.now().add(const Duration(days: 2))),
    DateFormat.EEEE().format(DateTime.now().add(const Duration(days: 3))),
    DateFormat.EEEE().format(DateTime.now().add(const Duration(days: 4))),
    DateFormat.EEEE().format(DateTime.now().add(const Duration(days: 5))),
    DateFormat.EEEE().format(DateTime.now().add(const Duration(days: 6))),
  ];
  List month = [
    //Tuesday Oct 08
    DateFormat.MMM().format(DateTime.now()),
    DateFormat.MMM().format(DateTime.now().add(const Duration(days: 1))),
    DateFormat.MMM().format(DateTime.now().add(const Duration(days: 2))),
    DateFormat.MMM().format(DateTime.now().add(const Duration(days: 3))),
    DateFormat.MMM().format(DateTime.now().add(const Duration(days: 4))),
    DateFormat.MMM().format(DateTime.now().add(const Duration(days: 5))),
    DateFormat.MMM().format(DateTime.now().add(const Duration(days: 6))),
  ];
  List dayNum = [
    //Tuesday Oct 08
    DateFormat.d().format(DateTime.now()),
    DateFormat.d().format(DateTime.now().add(const Duration(days: 1))),
    DateFormat.d().format(DateTime.now().add(const Duration(days: 2))),
    DateFormat.d().format(DateTime.now().add(const Duration(days: 3))),
    DateFormat.d().format(DateTime.now().add(const Duration(days: 4))),
    DateFormat.d().format(DateTime.now().add(const Duration(days: 5))),
    DateFormat.d().format(DateTime.now().add(const Duration(days: 6))),
  ];
  AppointmentsListDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SecretariaLyoutCubit(),
      child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.all(10.h),
                 child: Container(
                  height: MediaQuery.of(context).size.height * .07,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        SecretariaLyoutCubit.get(context).showAppointment();
                        indexList = index;
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .1,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            children: [
                              Text(
                                '${days[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${month[index]} ${dayNum[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: MediaQuery.of(context).size.width * .03,
                    ),
                    itemCount: 7,
                  ),
                ),
              ),
              SecretariaLyoutCubit.get(context).showAppointments ?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    ConditionalBuilder(
                      condition: state is! ApppintmentListLoadingState,
                      builder: (context) => Container(
                        width: screenSize.width,
                        height: MediaQuery.of(context).size.height * .72,
                        child: AppointmentsRequestsView(token: CacheHelper.getData(key: 'Token'), date: '${days[indexList]} ${month[indexList]} ${dayNum[indexList]}'),
                      ),
                      fallback: (context) => const CircularProgressIndicator(),
                    ),
                  ],
                ),
              )
              : Container(
                height: 498.h,
                child: Center(
                  child: Text(
                    'Please Select Day',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
