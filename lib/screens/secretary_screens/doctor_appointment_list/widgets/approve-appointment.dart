import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../main.dart';
import '../../api_cubit/api_cubit.dart';
import '../../api_cubit/api_states.dart';
import 'appointments_list_doctor_item.dart';

class ApproveAppointment extends StatelessWidget {

  final int doctorId;

  const ApproveAppointment({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecretariaLyoutCubit()..dateHaveApproveAppointment(doctor_id: doctorId),
      child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
          if(state is DateApproveAppointmentErrorState)
          {
            return Padding(
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
            );
          }else if(state is DateApproveAppointmentLoadingState)
          {
            return const Center(child: CircularProgressIndicator());
          }else
          {
            return Column(
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
                                  cubit.dateApproveAppointmentModel.appointment[index].date,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                /*Text(
                                  '${cubit.month[index]} ${cubit.dayNum[index]}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),*/
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
            );
          }
        },
      ),
    );
  }
}
