import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_divider.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_progress_indicator.dart';
import '../home_doctor_screen/home_doctor_cubit/home_cubit.dart';
import '../patients_session_screen/cubit/session_cubit.dart';
import '../widget/custom_button.dart';
import '../widget/custom_navigate.dart';

class ShowAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   return BlocConsumer<DoctorCubit,DoctorStates>(
          builder: (context ,state)
          {
            if(state is DoctorViewAppointmentSuccessState)
            {
              if(state.appointments.isEmpty)
              {
                return Center(
                  child: Text(
                    'All Appointment is Done',
                    style: TextStyle(color: Colors.grey, fontSize: 20.w),
                  ),
                );
              }
              else
              {
                 return listOfAppointment(state);
              }
            }else
            {
              return const CustomeProgressIndicator();
            }
          },
       listener:(context ,state)
       {
         if (state is DoctorViewAppointmentErrorState)
         {
           CustomeSnackBar.showErrorSnackBar(
             context,
             msg: state.error,
           );
         }
       });
  }
}

Widget listOfAppointment(DoctorViewAppointmentSuccessState state ) => ListView.separated(
  itemBuilder: (context, index) => appointmentItemBuilder(context,state,index),
  separatorBuilder: (context, index) => myDivider(),
  itemCount: state.appointments.length,
);
Widget appointmentItemBuilder(BuildContext context, DoctorViewAppointmentSuccessState state, int index) => Padding(
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
                      Text(
                        //'date and time',
                        'time : ${state.appointments[index].time.toString()}',
                        style: const TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                   Row(
                    children: [
                     const Icon(
                         Icons.access_time,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        //'date and time',
                          'date : ${state.appointments[index].date.toString()}',
                        style: const TextStyle(fontSize: 15.0),
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
                      Text(
                         // 'description :',
                      'from : ${state.appointments[index].patientModel.userModel?.firstName.toString()} ${state.appointments[index].patientModel.userModel?.lastName.toString()}',
                        style: const TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                   SizedBox(
                     height: 2.h,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       SizedBox(
                        width: 160.w,
                      ),
                      defButton(
                        function: ()
                        {
                          navigateTo(context, AddSessionScreen( appointmentId: state.appointments[index].id, ));
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




class AddSessionScreen extends StatelessWidget{

  var medicineController = TextEditingController();
  var reportController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final int appointmentId ;

   AddSessionScreen({required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit(),
      child: BlocConsumer<SessionCubit,SessionStates>(
        builder: (context,state)
        {
          SessionCubit cubit =  SessionCubit.get(context);
          var image  =  SessionCubit.get(context).imageOfSession;

          return Scaffold(
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
            ),
            title: Text(
              'Add Session',
              style: TextStyle(fontSize: 20.w),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              maxLines: 1,
                              autofocus: true,
                              cursorColor: defaultColor,
                              controller: medicineController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: 'Enter a medicine',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: defaultColor,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              onFieldSubmitted: (String value)
                              {

                              },
                              onChanged: (String value)
                              {
                                print(value);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'field mustn\'t be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            TextFormField(
                              maxLines: 1,
                              autofocus: true,
                              cursorColor: defaultColor,
                              controller: reportController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: 'Enter a report',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: defaultColor,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              onFieldSubmitted: (String value)
                              {

                              },
                              onChanged: (String value)
                              {
                                print(value);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'field mustn\'t be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:Align(
                                child:Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children:
                                  [
                                    Container(
                                      width: double.infinity,
                                      height: 170.0,
                                      child: image ==null ? const Center(
                                        child: Text(
                                          'No image selected',
                                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                        ),
                                      )
                                          : Image.file(
                                        File('${image}').absolute,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    CircleAvatar(
                                      backgroundColor: defaultColor,
                                      radius: 18.0,
                                      child:IconButton(
                                        onPressed: ()
                                        {
                                          cubit.getImage();
                                        },
                                        icon:const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            defButton(
                                width: 170.w,
                                function: ( )
                                {
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.postWithImage(
                                      body:
                                      {
                                        'appointment_id': '${appointmentId}',
                                        'medicine': medicineController.text,
                                        'report': reportController.text,
                                      } ,
                                      imagePath:'${image}' ,
                                      endPoint: 'session/store',
                                      token:CacheHelper.getData(key: 'Token'));

                                   // navigateAndReplacement(context,ShowAppointmentScreen());
                                    Navigator.pop(context);
                                  }
                                },
                                text: 'add',
                                radius: 25.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
          },
        listener: (context,state){},
      ));
  }
}