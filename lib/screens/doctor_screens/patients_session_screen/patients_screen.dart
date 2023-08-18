import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/screens/doctor_screens/patients_session_screen/view_patient_and_his_session.dart';
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
    return BlocConsumer<DoctorCubit, DoctorStates>(
        builder: (context, state) {
      if (state is GetPatientsSuccessState)
      {
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
      }
      else {
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
          /*DoctorCubit.get(context).getSession( token: CacheHelper.getData(key: 'Token'),
          patientId: state.patient[index].id!);*/

        navigateTo(context, ViewPatientWithHisSessions( state.patient[index].id!,index));
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

