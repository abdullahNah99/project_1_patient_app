import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_divider.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_navigate.dart';
import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_progress_indicator.dart';
import '../home_doctor_screen/home_doctor_cubit/home_cubit.dart';

class ShowPatientsAndSessionScreen extends StatelessWidget {
  const ShowPatientsAndSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorStates>(builder: (context, state) {
      if (state is GetPatientsSuccessState) {
        if (state.patient.isEmpty) {
          return Center(
            child: Text(
              'No Patient Yet',
              style: TextStyle(color: Colors.grey, fontSize: 20.w),
            ),
          );
        } else {
          return listOfPatient(state);
        }
      } else {
        return const CustomeProgressIndicator();
      }
    }, listener: (context, state) {
      if (state is GetPatientsErrorState) {
        CustomeSnackBar.showErrorSnackBar(
          context,
          msg: state.error,
        );
      }
    });
  }
}

Widget listOfPatient(GetPatientsSuccessState state) => ListView.separated(
      itemBuilder: (context, index) =>
          patientItemBuilder(context, state, index),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: state.patient.length,
    );

Widget patientItemBuilder(BuildContext context, GetPatientsSuccessState state, int index) =>
    Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
      child: MaterialButton(
        onPressed: () {
          navigateTo(context, ViewPatientWithHisSessions(state,index));
        },
        child: Container(
          padding: const EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Row(
            children: [
              CustomeImage(
                height: 55.h,
                width: 55.w,
                image: 'assets/images/undraw_Coffee_Time_e8cw.png',
                borderRadius: BorderRadius.circular(50.0),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                // 'name',
                '${state.patient[index].userModel?.firstName.toString()} ${state.patient[index].userModel?.lastName.toString()}',
                style: const TextStyle(
                  color: defaultColor,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );

class ViewPatientWithHisSessions extends StatelessWidget {
  GetPatientsSuccessState state;
  int index;
  ViewPatientWithHisSessions(this.state,this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.r),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Some details about the patient',
                style: TextStyle(color: Colors.black, fontSize: 18.w),),],
            ),
            SizedBox(height: 5.h,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:
                  [
                    Row(
                      children: [
                        const Icon(
                          Icons.title_outlined,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'full name : ${state.patient[index].userModel?.firstName.toString()} ${state.patient[index].userModel?.lastName.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        const Icon(
                          Icons.cake_outlined,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'birthDate : ${state.patient[index].birthDate.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        const Icon(
                          Icons.male,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'gender : ${state.patient[index].gender.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone_android_outlined,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'phone : ${state.patient[index].userModel?.phoneNum.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'email : ${state.patient[index].userModel?.email.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'address : ${state.patient[index].address.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,),
                  ],
                ),
              ),),
            const SizedBox(
              height: 13.0,
            ),
            Row(
             children: [
               Text('All Session',
                 style: TextStyle(color: Colors.black, fontSize: 18.w)),],
           ),
            SizedBox(height: 5.h,),
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index)=> MaterialButton(
                      onPressed: ()
                      {

                      },
                      child:Padding(
                        padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                        child:  Container(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child:  Row(
                            children: [
                              CircleAvatar(
                                radius:14.0 ,
                                backgroundColor: defaultColor,
                                child: Text('1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'session',
                                style: const TextStyle(
                                  color: defaultColor,
                                  fontSize: 18.0,
                                ),
                              ),
                              Spacer(),
                              IconButton(onPressed: (){}, icon: Icon(
                                Icons.delete,
                                size: 20.0,
                              ))
                            ],
                          ),
                        ),
                      ),

                    ),

                    itemCount: 5),),
          ],
        ),
      ),
           );
  }
}
