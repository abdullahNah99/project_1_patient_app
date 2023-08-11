import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/doctor_screens/home_doctor_screen/home_doctor_cubit/cubit.dart';
import 'package:patient_app/screens/doctor_screens/home_doctor_screen/home_doctor_cubit/states.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_divider.dart';
import '../widget/custom_button.dart';

class ShowAppointmentScreen extends StatelessWidget {
  const ShowAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorStates>(
        builder: (context ,state)
        {
          return ConditionalBuilder(
              condition: true,
              builder: (context) => listOfAppointment(),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
          /*if(state is DoctorViewAppointmentErrorState)
          {
            return const Text('Error Occurred');
          }
          if(state is DoctorViewAppointmentSussesState)
          {
            return ConditionalBuilder(
                condition: true,
                builder: (context) => listOfAppointment(),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));

          }else
          {
            return const Center(child: CircularProgressIndicator(),);
          }*/
        }, listener:(context ,state){});
  }
}

Widget listOfAppointment() =>ListView.separated(
  itemBuilder: (context, index) => appointmentItemBuilder(context),
  separatorBuilder: (context, index) => myDivider(),
  itemCount: 4,
);
Widget appointmentItemBuilder(BuildContext context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                   Row(
                    children: [
                     const Icon(
                         Icons.access_time,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Text(
                        'date:  and time: ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                   Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Text(
                          'description : ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                   Row(
                    children: [
                     const Icon(
                        Icons.arrow_circle_down_rounded,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Text(
                        'from :department name',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                   SizedBox(
                     height: 3.h,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       SizedBox(
                        width: 160.w,
                      ),
                      defButton(
                        function: ()
                        {
                          //DoctorCubit.get(context).fetchMyInfo();
                          DoctorCubit.get(context).getMyId();
                          print( DoctorCubit.get(context).getMyId());
                          DoctorCubit.get(context).viewAppointment(doctor_id: DoctorCubit.get(context).getMyId());
                        },
                        text: 'add session',
                        radius: 25.0,
                        width: 130.w,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
