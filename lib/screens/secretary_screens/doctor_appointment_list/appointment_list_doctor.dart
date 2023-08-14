import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_cubit.dart';
import 'package:patient_app/screens/secretary_screens/doctor_appointment_list/widgets/appointments_list_doctor_item.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_arrow_back_button.dart';
import '../api_cubit/api_states.dart';

class AppointmentsListDoctor extends StatelessWidget {

  final int doctorId;

  const AppointmentsListDoctor({
    super.key,
    required this.doctorId
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SecretariaLyoutCubit()..dateHaveApproveAppointment(doctor_id: doctorId),
      child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
          if(state is DateApproveAppointmentErrorState)
          {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: defaultColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(20.r))),
                automaticallyImplyLeading: false,
                centerTitle: true,
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    top: 8.5.w,
                    bottom: 8.5.w,
                  ),
                  child: const CustomArrowBackIconButton(),
                ),
                title: const Text(
                  'Appointments',
                ),
              ),
              body: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 15.0,
                  end: 15.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Center(
                  child: Text(
                    'There is some thing error',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            );
          }else if(state is DateApproveAppointmentLoadingState)
          {
            return Container(
              width: screenSize.width,
              height: screenSize.height,
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator())
            );
          }else
          {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: defaultColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(20.r))),
                automaticallyImplyLeading: false,
                centerTitle: true,
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    top: 8.5.w,
                    bottom: 8.5.w,
                  ),
                  child: const CustomArrowBackIconButton(),
                ),
                title: const Text(
                  'Appointments',
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.all(10.h),
                      child: SizedBox(
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
                                      cubit.dateApproveAppointmentModel.appointment[index].date.replaceRange(cubit.dateApproveAppointmentModel.appointment[index].date.length - 6, cubit.dateApproveAppointmentModel.appointment[index].date.length, ''),
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      cubit.dateApproveAppointmentModel.appointment[index].date.replaceRange(0, cubit.dateApproveAppointmentModel.appointment[index].date.length - 6, ''),
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
                          itemCount: cubit.dateApproveAppointmentModel.appointment.length,
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
                            builder: (context) => SizedBox(
                              width: screenSize.width,
                              height: MediaQuery.of(context).size.height * .72,
                              child: ApproveAppointmentsListDoctorItem(token: CacheHelper.getData(key: 'Token'), doctorId: doctorId, date: cubit.dateApproveAppointmentModel.appointment[cubit.indexList].date),
                            ),
                            fallback: (context) => const CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    )
                        : SizedBox(
                      height: 498.h,
                      child: Center(
                        child: Text(
                          'Please Select Day',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          /*return Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(20.r))),
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  top: 8.5.w,
                  bottom: 8.5.w,
                ),
                child: const CustomArrowBackIconButton(),
              ),
              title: Text(
                'Appointments',
              ),
              *//*actions: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: 20.w,
                  ),
                  child: const CustomArrowBackIconButton(),
                ),
              ],*//*
            ),
            body:
          );*/
        },
      ),
    );
  }
}

/*
SingleChildScrollView(
  child: Column(
    children: [
      Align(
        alignment: AlignmentDirectional.bottomStart,
        child: Container(
          height: 45.h,
          width: screenSize.width,
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide.none),
          ),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: TextButton(
                    onPressed: (){
                      if(cubit.showApproveDays )
                      {

                      }else
                      {
                        cubit.showDay(type: 'Waiting');
                      }
                    },
                    child: Container(
                      height: 35.h,
                      width: 100.w,
                      //color: cubit.colorTypeItem[0] ? Colors.purple.shade300 : Colors.grey.shade400,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        'Waiting',
                        style: TextStyle(
                          color: cubit.colorTypeItem[0] ? Colors.purple.shade300 : Colors.black,
                          fontSize: 18.w,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1.w,
                child: Container(
                  color: Colors.grey.shade500,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: TextButton(
                    onPressed: () {
                      if(cubit.showWaitingDays)
                      {

                      }else
                      {
                        cubit.showDay(type: 'Approve');
                      }
                    },
                    child: Container(
                      height: 35.h,
                      width: 100.w,
                      //color: cubit.colorTypeItem[1] ? Colors.purple.shade300 : Colors.grey.shade400,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        'Approve',
                        style: TextStyle(
                          color: cubit.colorTypeItem[1] ? Colors.purple.shade300 : Colors.black,
                          fontSize: 18.w,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: SizedBox(
          height: 1.h,
          child: Container(
            color: Colors.grey.shade500,
          ),
        ),
      ),
      cubit.showWaitingDays ? WaitingAppointment()
      : cubit.showApproveDays ? ApproveAppointment(doctorId: doctorId,)
      : Container(
        height: 498.h,
        child: Center(
          child: Text(
            'Please Select Type',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
    ],
  ),
),
 */
