

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/screens/doctor_screens/doctor_cubit/cubit.dart';
import 'package:patient_app/screens/doctor_screens/doctor_cubit/states.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_divider.dart';
import 'package:patient_app/screens/patient_screens/home_patient_screen/widgets/custom_drawer_button.dart';

class DoctorHomeScreen extends StatelessWidget {
  static const route = 'DoctorHomeScreen';
  final String token;
  DoctorHomeScreen({super.key, required this.token});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCubit(),
      child: BlocConsumer<DoctorCubit, DoctorStates>(
        listener: (context, state) {},
        builder: (context, state) {


          DoctorCubit homeCubit = BlocProvider.of<DoctorCubit>(context);
          DoctorCubit cubit = DoctorCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              width: 250.w,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomeImage(
                        height: 55.h,
                        width: 55.w,
                        borderRadius: BorderRadius.circular(50.r),
                        iconSize: 35.sp,
                      ),
                    SizedBox(height: 14.h,),
                    Text(
                      'dr food',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 22.h,),
                    divider(),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        const Icon(Icons.date_range_rounded),
                        SizedBox(width: 15.w,),
                        Text(
                          'Appointment',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        const Icon(Icons.question_answer_outlined),
                        SizedBox(width: 15.w,),
                        Text(
                          'Consulting',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        const Icon(Icons.medical_information_outlined),
                        SizedBox(width: 15.w,),
                        Text(
                          'My Sessions',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        const Icon(Icons.work_history_outlined),
                        SizedBox(width: 15.w,),
                        Text(
                          'Time off',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Padding(
                     padding:const EdgeInsets.only(right: 20.0),
                     child:CustomDrawerButton(
                     text: 'Logout',
                     icon: Icons.logout,
                     iconColor: Colors.red,
                     onPressed: () {
                       scaffoldKey.currentState!.closeDrawer();
                       homeCubit.logout(context);
                     },
                   ),),
                    SizedBox(height: 25.h),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              title: Text(
                'Welcome', //${homeCubit.patientModel?.userModel?.firstName ?? ''}
                style: TextStyle(fontSize: 20.w),
              ),
              actions: const [
                Icon(Icons.notifications),
                SizedBox(width: 5),
              ],
            ),
            body:const Center(
              child:Text('hello dr food'),
            ),
          );
        },
      ),
    );
  }
}
