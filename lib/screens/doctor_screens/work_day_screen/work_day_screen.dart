import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_divider.dart';
import 'package:patient_app/screens/doctor_screens/work_day_screen/cubit/cubit.dart';
import 'package:patient_app/screens/doctor_screens/work_day_screen/cubit/states.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_progress_indicator.dart';

class WorkTimesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkTimesCubit()
        ..getMyWorkTimes(
            token: CacheHelper.getData(
                key: 'Token')), //..getWorkDay(token:Constants.adminToken)
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.r),
            ),
          ),
          title: Text(
            'My Work Times',
            style: TextStyle(fontSize: 20.w),
          ),
        ),
        body: const WorkTimesViewBody(),
      ),
    );
  }
}

class WorkTimesViewBody extends StatelessWidget {
  const WorkTimesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkTimesCubit, WorkTimesStates>(
      builder: (context, state) {
        if (state is ViewWorkTimesSussesState) {
          if (state.times.isEmpty) {
            return Center(
              child: Text(
                'Times is empty',
                style: TextStyle(color: Colors.grey, fontSize: 30.w),
              ),
            );
          } else {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10, top: 10.0),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 15.0, bottom: 10.0, top: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // 'day',
                            state.times[index].day,
                            style: const TextStyle(
                              color: defaultColor,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            //'startTime and endTime',
                            '${state.times[index].startTime}   ${state.times[index].endTime}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      /* const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15.0,
                                ),
                              ),*/
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: state.times.length,
            );
          }
        } else {
          return const CustomeProgressIndicator();
        }
      },
      listener: (context, state) {
        if (state is ViewWorkTimesErrorState) {
          CustomeSnackBar.showErrorSnackBar(
            context,
            msg: state.error,
          );
        }
      },
    );
  }
}

/*
* ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.times.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10.0, bottom: 5.0, top: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            children: [
                               Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                   // 'day',
                                    state.times[index].day,
                                    style:const TextStyle(
                                      color: defaultColor,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    //'startTime and endTime',
                                    '${state.times[index].startTime}   ${state.times[index].endTime}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),*/
