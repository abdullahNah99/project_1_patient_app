
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_cubit.dart';

import '../../../core/widgets/custome_progress_indicator.dart';
import '../api_cubit/api_states.dart';
import '../appointments_requests_screen/appointments_requests_view.dart';

class AppointmentsListDate extends StatelessWidget {

  const AppointmentsListDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SecretariaLyoutCubit()..dateHaveWaitingAppointment(),
      child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
          if(state is DateWaitingAppointmentErrorState)
          {
            return Padding(
              padding: EdgeInsetsDirectional.only(
                start: 15.0,
                end: 15.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Center(
                    child: Text(
                      'There Are No Appointment',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            );
          }else if (state is! DateWaitingAppointmentLoadingState) {
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
                          cubit.indexList = index;
                          SecretariaLyoutCubit.get(context).showAppointment();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.height * .1,
                          decoration: BoxDecoration(
                            color: cubit.colorItem[index] ? Colors.purple.shade300 : Colors.grey.shade400,
                            borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Column(
                              children: [
                                Text(
                                  //'${cubit.days[index]}',
                                  cubit.dateWaitingAppointmentModel.appointment[index].date.replaceRange(cubit.dateWaitingAppointmentModel.appointment[index].date.length - 6, cubit.dateWaitingAppointmentModel.appointment[index].date.length, ''),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  cubit.dateWaitingAppointmentModel.appointment[index].date.replaceRange(0, cubit.dateWaitingAppointmentModel.appointment[index].date.length - 6, ''),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: MediaQuery.of(context).size.width * .03,
                      ),
                      itemCount: cubit.dateWaitingAppointmentModel.appointment.length,
                    ),
                  ),
                ),
                cubit.showAppointments ?
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
                          child: AppointmentsRequestsView(token: CacheHelper.getData(key: 'Token'), date: cubit.dateWaitingAppointmentModel.appointment[cubit.indexList].date),
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
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const CustomeProgressIndicator();
          }
        },
      ),
    );
  }
}
