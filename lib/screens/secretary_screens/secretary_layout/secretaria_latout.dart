import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custome_image.dart';
import '../../patient_screens/home_patient_screen/cubits/home_cubit/home_patient_cuibt.dart';
import '../../patient_screens/home_patient_screen/widgets/custom_drawer_button.dart';
import '../api_cubit/api_cubit.dart';
import '../api_cubit/api_states.dart';
import '../secretary_profile/secretary_profile.dart';

class SecretariaLayout extends StatelessWidget {

  static const route = 'SecretariaLayout';



  SecretariaLayout({super.key});


  @override
  Widget build(BuildContext context) {
    log('AppointmentsRequestsView xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SecretariaLyoutCubit()..indexPatient(),
        ),
        BlocProvider(
          create: (context) => HomePatientCubit(),
        )
      ],
      child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          SecretariaLyoutCubit cubit = BlocProvider.of(context);
          HomePatientCubit homeCubit = BlocProvider.of<HomePatientCubit>(context);
          return Scaffold(

            drawer: Drawer(
              width: 250.w,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180.h,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                          child: CustomeImage(
                            height: 75.h,
                            width: 80.w,
                            borderRadius: BorderRadius.circular(50.r),
                            iconSize: 60.sp,
                            image: AppAssets.sec,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                  CustomDrawerButton(
                    text: 'Profile',
                    icon: Icons.account_circle,
                    //iconColor: Colors.,
                    onPressed: () {
                      cubit.scaffoldKey.currentState?.closeDrawer();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecretaryProfile(userId: cubit.getMyId()/*model.appointment[index!].patient.userId*/,)),
                      );
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  CustomDrawerButton(
                    text: 'Log Out',
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    onPressed: () {
                      //cubit.scaffoldKey.currentState!.closeDrawer();
                      homeCubit.logout(context);
                    },
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              title: const Text(
                'Welcom',
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changBottomNavBar(value);
              },
              items: cubit.bottomNavBarItem,
            ),
            body: cubit.page[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
