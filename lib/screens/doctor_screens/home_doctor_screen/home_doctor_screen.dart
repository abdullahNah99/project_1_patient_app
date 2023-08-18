
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consult_doctor_cubit/cubit.dart';
import 'package:patient_app/screens/doctor_screens/home_doctor_screen/home_doctor_cubit/home_cubit.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_divider.dart';
import '../my_account_screen/my_account_screen.dart';
import '../widget/custom_button.dart';
import '../widget/custom_navigate.dart';
import '../work_day_screen/work_day_screen.dart';



class DoctorHomeScreen extends StatelessWidget {
  static const route = 'DoctorHomeScreen';
  final String token;
  
  DoctorHomeScreen({super.key, required this.token});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DoctorCubit()..fetchMyInfo()..getPatients(token: token)

        ),
        BlocProvider(
          create: (context) => DoctorConsultCubit()..getQuestion(),
        ),
       /* BlocProvider(
          create: (context) => SessionCubit()..getPatients(token: CacheHelper.getData(
              key: 'Token')),
        ),
*/
      ],

      child: BlocConsumer<DoctorCubit, DoctorStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          DoctorCubit cubit = BlocProvider.of<DoctorCubit>(context);

          return Scaffold(
            key: scaffoldKey,

            drawer: Drawer(
              width: 250.w,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(padding:const EdgeInsets.only(left: 19.0),
                      child: CustomeNetworkImage(
                        imageUrl: cubit.doctorModel?.imagePath,
                        fit: BoxFit.contain,
                        height: 75.h,
                        width: 75.h,
                        borderRadius: BorderRadius.circular(50.r),
                        iconSize: 55.sp,
                     )
                    ),
                    SizedBox(height: 14.h,),
                    Padding(padding:const EdgeInsets.only(left: 21.0),
                     child: Text(
                     cubit.doctorModel?.user.firstName ?? '',

                     style: TextStyle(
                         fontSize: 18.sp, fontWeight: FontWeight.bold),
                   ),),
                    SizedBox(height: 22.h,),
                    divider(),
                    SizedBox(height: 8.h),
                    defMaterialButton(
                      text:'My Account',
                      function: ()
                      {
                        navigateTo(context, MyAccountScreen());
                      },
                      icon: Icons.info_outline,
                    ),
                   /* defMaterialButton(
                        text: 'Appointment',
                        function: ()
                        {

                        },
                        icon: Icons.date_range_rounded,
                    ),*/
                    defMaterialButton(text: 'Consulting',
                        function: ()
                        {
                               navigateTo(context, Widget);
                        },
                        icon: Icons.question_answer_outlined),
                   /* defMaterialButton(text: 'My Sessions',
                        function: ()
                        {

                        },
                        icon: Icons.medical_information_outlined),*/
                    defMaterialButton(text: 'Time off',
                      function: ()
                      {
                        //scaffoldKey.currentState!.closeDrawer();
                        navigateTo(context, WorkTimesScreen());

                      },
                     icon: Icons.work_history_outlined),
                    defMaterialButton(
                        text:'Dark mode',
                        function: ()
                        {

                        },
                        icon: Icons.dark_mode_outlined),
                    const Expanded(
                        child: SizedBox()
                    ),
                      /* Padding(
                     padding:const EdgeInsets.only(right: 20.0),
                     child:CustomDrawerButton(
                     text: 'Logout',
                     icon: Icons.logout,
                     iconColor: Colors.red,
                     onPressed: () {
                       scaffoldKey.currentState!.closeDrawer();
                       cubit.logout(context);
                     },
                   ),),*/
                    defMaterialButton(
                        text:'Logout',
                        function: ()
                        {
                          scaffoldKey.currentState!.closeDrawer();
                          cubit.logout(context);
                        },
                        icon: Icons.logout_outlined),

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

            ),
            body: cubit.bottomNavScreens[cubit.currentIndex],
            bottomNavigationBar:BottomNavigationBar(
              currentIndex:cubit.currentIndex,
              onTap: (index)
              {
                cubit.currentIndex =index;
                print(index);
                cubit.changeBottomNav(index);
              },
              items: cubit.items,
            ),
          );
        },
      ),
    );
  }
}
