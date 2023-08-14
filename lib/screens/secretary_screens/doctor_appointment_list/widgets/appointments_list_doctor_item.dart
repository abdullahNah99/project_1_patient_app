import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_cubit.dart';

import '../../../../core/functions/custome_snack_bar.dart';
import '../../../../core/models/secretaria/secretaria_appointment/index_approve_appointment_by_date_model.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../../../core/widgets/register_text_field.dart';
import '../../../../main.dart';
import '../../api_cubit/api_states.dart';

class ApproveAppointmentsListDoctorItem extends StatelessWidget {
  static const route = 'AppointmentsRequestsView';

  final String token;
  final int doctorId;
  final String date;

  const ApproveAppointmentsListDoctorItem({super.key, required this.token, required this.doctorId , required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecretariaLyoutCubit()..indexApproveAppointmentByDate(doctor_id: doctorId, date: date),
      child: AppointmentsListDoctorBody(doctorId: doctorId, date: date,)
    );
  }
}

class AppointmentsListDoctorBody extends StatelessWidget {

  static final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  var cancelReason = TextEditingController();
  final int doctorId;
  final String date;

  AppointmentsListDoctorBody({super.key, required this.doctorId , required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
      listener: (context, state) {
        if(state is CancelAppointmentSuccssesState)
        {
          //Navigator.pop(context);
          CustomeSnackBar.showSnackBar(
            context,
            msg: 'Cancel Succsses',
            color: Colors.green,
          );
          SecretariaLyoutCubit.get(context).indexApproveAppointmentByDate(doctor_id: doctorId, date: date);
          //Navigator.pop(context);
        }else if(state is CancelAppointmentErrorState)
        {
          CustomeSnackBar.showSnackBar(
            context,
            msg: 'Cancel Failed',
            color: Colors.red,
          );
        }
      },
      builder: (context, state) {
        SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
        if(state is ApproveApppintmentListByDateErrorState)
        {
          return Padding(
            padding: EdgeInsetsDirectional.only(
              start: 15.0,
              end: 15.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Center(
                  child: Text(
                    'There Are No Appointment',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          );
        }else if (state is ApproveApppintmentListByDateSuccssesState) {
          return Scaffold(
            key: scaffoldKey,
            body: ListView.builder(
              itemBuilder: (context, index) => TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomeImage(
                        borderRadius: BorderRadius.circular(10),
                        width: 90.h,
                        height: 125.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //const _TextItem(text: 'From: Abdullah Nahlawi xxxxxxxxx'),
                          _TextItem(text: 'From: ${cubit.indexApproveAppointmentByDateModel.appointment[index].patient.user.firstName} ${cubit.indexApproveAppointmentByDateModel.appointment[index].patient.user.lastName}'),
                          SizedBox(height: 8.w),
                          //const _TextItem(text: 'Time: Sunday 5/7  03:00 PM'),
                          _TextItem(text: 'Time: ''${cubit.indexApproveAppointmentByDateModel.appointment[index].time}'.replaceRange(11, 14, ''),),
                          SizedBox(height: 8.w),
                          Row(
                            children: [
                              CustomeImage(
                                width: 20.h,
                                height: 20.h,
                                iconSize: 15.h,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              SizedBox(width: 5.w),
                              _TextItem(
                                //text: 'To: Dr. Abdullah Nahlawi',
                                text: 'To: Dr. ${cubit.indexApproveAppointmentByDateModel.appointment[index].doctor.user.firstName} ${cubit.indexApproveAppointmentByDateModel.appointment[index].doctor.user.lastName}',
                                width: 170.w,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.w),
                          SizedBox(
                            width: 210.w,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    scaffoldKey.currentState!.showBottomSheet(
                                      elevation: 00.0,
                                          (context) => Container(
                                        height: 175.h,
                                        width: screenSize.width,
                                        color: Colors.grey.shade100,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.020,
                                            ),
                                            Form(
                                              key: formKey,
                                              child: Padding(
                                                padding:  EdgeInsetsDirectional.only(
                                                  start: 10.w,
                                                  end: 0.w,
                                                ),
                                                child: RegisterTextField(
                                                  hintText: 'Reason ...',
                                                  icon: Icons.question_mark,
                                                  controller: cancelReason,
                                                  keyboardType: TextInputType.text,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.05,
                                            ),
                                            CustomeButton(
                                              text: 'Cancel',
                                              width: 250.w,
                                              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                              onPressed: (){
                                                if(formKey.currentState!.validate()){
                                                  cubit.cancelAppointment(cancel_reason: cancelReason.text, id: cubit.indexApproveAppointmentByDateModel.appointment[index].id);
                                                  SecretariaLyoutCubit.get(context).changeBottomSheet(isShow: true);
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.033,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ).closed.then((value) => {
                                      SecretariaLyoutCubit.get(context).changeBottomSheet(isShow: false),
                                    }
                                    );
                                  },
                                  highlightColor: Colors.black.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(30.h),
                                  child: Container(
                                    width: 70.h,
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.h),
                                      color: Colors.green.withOpacity(.6),
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: cubit.indexApproveAppointmentByDateModel.appointment.length/*state.appointments.length*/,
            ),
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }
}

class AppointmentsListDoctorBodyItem extends StatelessWidget {

  //final List<AppointmentModel> appointments;
  final int? index;
  final IndexApproveAppointmentByDateModel model;

  const AppointmentsListDoctorBodyItem({
    super.key,
    //required this.appointments
    this.index,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomeImage(
              borderRadius: BorderRadius.circular(10),
              width: 90.h,
              height: 125.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //const _TextItem(text: 'From: Abdullah Nahlawi xxxxxxxxx'),
                _TextItem(text: 'From: ${model.appointment[index!].patient.user.firstName} ${model.appointment[index!].patient.user.lastName}'),
                SizedBox(height: 8.w),
                //const _TextItem(text: 'Time: Sunday 5/7  03:00 PM'),
                _TextItem(text: 'Time: ''${model.appointment[index!].time}'.replaceRange(11, 14, ''),),//'${model.appointment[index!].time}'),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    CustomeImage(
                      width: 20.h,
                      height: 20.h,
                      iconSize: 15.h,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    SizedBox(width: 5.w),
                    _TextItem(
                      //text: 'To: Dr. Abdullah Nahlawi',
                      text: 'To: Dr. ${model.appointment[index!].doctor.user.firstName} ${model.appointment[index!].doctor.user.lastName}',
                      width: 170.w,
                    ),
                  ],
                ),
                SizedBox(height: 8.w),
                SizedBox(
                  width: 210.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      _HandleButton(/*model: model, */index: index! < 0 ? 0 : index!,),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HandleButton extends StatelessWidget {

  final int? index;
  //final IndexAppointmentByDateModel model;
  final formKey = GlobalKey<FormState>();
  var cancelReason = TextEditingController();

  _HandleButton({
    this.index,
    //required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecretariaLyoutCubit(),
      child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return InkWell(
            onTap: () {
              /*scaffoldKey.currentState!.showBottomSheet(
                elevation: 00.0,
                    (context) => Container(
                  height: 175.h,
                  width: screenSize.width,
                  color: Colors.grey.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding:  EdgeInsetsDirectional.only(
                            start: 10.w,
                            end: 0.w,
                          ),
                          child: RegisterTextField(
                            lableText: 'Reason',
                            icon: Icons.question_mark,
                            controller: cancelReason,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      CustomeButton(
                        text: 'Cancel',
                        width: 250.w,
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            cubit.cancelAppointment(cancel_reason: cancelReason.text, id: model.appointment[index!].id);
                            SecretariaLyoutCubit.get(context).changeBottomSheet(isShow: true);
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.033,
                      ),
                    ],
                  ),
                ),
              ).closed.then((value) => {
                SecretariaLyoutCubit.get(context).changeBottomSheet(isShow: false),
              }
              );*/
            },
            highlightColor: Colors.black.withOpacity(.7),
            borderRadius: BorderRadius.circular(30.h),
            child: Container(
              width: 70.h,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.h),
                color: Colors.green.withOpacity(.6),
              ),
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}

class _TextItem extends StatelessWidget {
  final String text;
  final double? width;
  // ignore: unused_element
  const _TextItem({required this.text, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 210.w,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black.withOpacity(.46),
        ),
      ),
    );
  }
}

