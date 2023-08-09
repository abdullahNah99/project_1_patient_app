import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custome_image.dart';
import '../../patient_screens/home_patient_screen/cubits/home_cubit/home_patient_cuibt.dart';
import '../../patient_screens/home_patient_screen/widgets/custom_drawer_button.dart';
import '../api_cubit/api_cubit.dart';
import '../api_cubit/api_states.dart';

class SecretariaLayout extends StatelessWidget {

  static const route = 'SecretariaLayout';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SecretariaLayout({super.key});


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SecretariaLyoutCubit(),
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
            key: _scaffoldKey,
            backgroundColor: Colors.grey.shade50,
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
                        Center(
                          child: CustomeImage(
                            height: 75.h,
                            width: 80.w,
                            borderRadius: BorderRadius.circular(50.r),
                            iconSize: 60.sp,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomDrawerButton(
                    text: 'Log Out',
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    onPressed: () {
                      _scaffoldKey.currentState!.closeDrawer();
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
              /*leading: IconButton(
                icon: const Icon(
                  Icons.logout,
                ),
                onPressed: ()
                {
                  SecretariaLyoutCubit.get(context).logOut(context: context);
                },
              ),*/
              title: Text(
                'Welcom',
                style: TextStyle(fontSize: 20.w),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
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
