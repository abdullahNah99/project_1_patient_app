import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/doctor_screens/patients_session_screen/cubit/session_cubit.dart';
import 'package:patient_app/screens/doctor_screens/patients_session_screen/view_and_update_session.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_navigate.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/styles/app_colors.dart';

class ViewPatientWithHisSessions extends StatelessWidget
{
  //GetPatientsSuccessState state;
  // int index;
  //ViewPatientWithHisSessions(this.index);
  int patientId;
  int index;
  ViewPatientWithHisSessions(this.patientId,this.index);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> SessionCubit()..getPatientAndSession(
        token:  CacheHelper.getData(key: 'Token'),
         patientId: patientId),
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.r),
            ),
          ),
        ),
        body: ViewPatientWithHisSessionsBody(index),
      ),);
  }
}
class ViewPatientWithHisSessionsBody extends StatelessWidget
{
  int index;
  ViewPatientWithHisSessionsBody(this.index);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SessionCubit,SessionStates>(builder: (context,state)
    {
      if(state is GetPatientAndSessionSuccess)
      {
        if(state.session.isEmpty)
        {
          return  Padding(
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

                Expanded(
                    child: Center(
                      child: Text('no session yet',
                        style: TextStyle(color: Colors.grey, fontSize: 30.w),),
                    )),
              ],
            ),
          );
        }
        else if(state.session.isEmpty && state.patient.isEmpty)
        {
          return  Center(
            child: Text('Error in get patient and his sessions',
              style: TextStyle(color: Colors.grey, fontSize: 30.w),),
          );
        }
        else
        {
          return Padding(
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
                  child: listOfSession(state),),
              ],
            ),
          );
        }
      }
      else
      {
        return const CustomeProgressIndicator();
      }
    }, listener:(context, state)
    {
      if(state is GetPatientsErrorState)
      {
        CustomeSnackBar.showErrorSnackBar(
          context,
          msg: state.error,
          color: Colors.red,
        );
      }


    } );
  }

}
Widget listOfSession(GetPatientAndSessionSuccess state) => ListView.builder(
    itemBuilder: (context, index)=> sessionItemBuilder(context ,state,index),
    itemCount: state.session.length,
);


Widget sessionItemBuilder(BuildContext context,GetPatientAndSessionSuccess  state, int index) => Padding(
  padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
  child:MaterialButton(
    onPressed: ()
    {
      navigateTo(context, UpdateSessionScreen(state,index));

    },
    child: Container(
      padding: const EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child:  Row(
        children: [
          CircleAvatar(
            radius:14.0 ,
            backgroundColor: defaultColor,
            child: Text(
              //'1',
              '${state.session[index].id}',

              style:const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),),
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Text(
            'session',
            style: const TextStyle(
              color: defaultColor,
              fontSize: 18.0,
            ),
          ),
          const Spacer(),
          IconButton(onPressed: ()
          {
           SessionCubit.get(context).deleteSession(
                token: CacheHelper.getData(key: 'Token'),
                sessionId: state.session[index].id!,
           );
          }, icon: Icon(
            Icons.delete,
            size: 20.0,
          ))
        ],
      ),
    ),
  ),
);