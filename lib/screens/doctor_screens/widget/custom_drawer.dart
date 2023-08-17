
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_button.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_divider.dart';
import '../../../core/widgets/custome_image.dart';
import '../../patient_screens/home_patient_screen/widgets/custom_drawer_button.dart';
import '../home_doctor_screen/home_doctor_cubit/home_cubit.dart';

abstract class CustomDrawer {
  static Drawer getCustomDrawer(
      BuildContext context, {
        required DoctorCubit doctorCubit,
        required GlobalKey<ScaffoldState> scaffoldKey,
      }) {
    return Drawer(
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
              child: CustomeImage(
                height: 55.h,
                width: 55.w,
                borderRadius: BorderRadius.circular(50.r),
                iconSize: 35.sp,
              ),),
            SizedBox(height: 14.h,),
            Padding(padding:const EdgeInsets.only(left: 19.0),
              child: Text(
                //'dr food',
                doctorCubit.doctorModel?.user?.firstName ?? '',
                style: TextStyle(
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),),
            SizedBox(height: 22.h,),
            divider(),
            SizedBox(height: 8.h),
            defMaterialButton(
              text:'My Account',
              function: (){},
              icon: Icons.info_outline,
            ),
            defMaterialButton(
              text: 'Appointment',
              function: ()
              {

              },
              icon: Icons.date_range_rounded,
            ),
            defMaterialButton(text: 'Consulting',
                function: ()
                {

                },
                icon: Icons.question_answer_outlined),
            defMaterialButton(text: 'My Sessions',
                function: ()
                {

                },
                icon: Icons.medical_information_outlined),
            defMaterialButton(text: 'Time off',
                function: ()
                {
                  scaffoldKey.currentState!.closeDrawer();
                 /* navigateTo(
                    context,
                   // WorkTimesListView(),
                  );*/
                },
                icon: Icons.work_history_outlined),
            defMaterialButton(
                text:'Dark mode',
                function: ()
                {

                },
                icon: Icons.dark_mode_outlined),
            const Expanded(child: SizedBox()),
            Padding(
              padding:const EdgeInsets.only(right: 20.0),
              child:CustomDrawerButton(
                text: 'Logout',
                icon: Icons.logout,
                iconColor: Colors.red,
                onPressed: () {
                  scaffoldKey.currentState!.closeDrawer();
                  doctorCubit.logout(context);
                },
              ),),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
