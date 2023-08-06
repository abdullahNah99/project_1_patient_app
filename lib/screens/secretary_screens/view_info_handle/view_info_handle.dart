import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:patient_app/core/models/secretaria/secretaria_appointment/index_appointment_by_date_model.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_cubit.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';

import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custome_arrow_back_button.dart';
import '../../../core/widgets/custome_button.dart';
import '../../../core/widgets/custome_image.dart';
import '../../../core/widgets/custome_progress_indicator.dart';
import '../../../core/widgets/register_text_field.dart';
import '../doctor_profile/doctor_profile.dart';
import '../patient_profile/patient_profile.dart';

class ViewInfoHandle extends StatelessWidget {

  static const route = 'ViewInfoHandle';

  final IndexAppointmentByDateModel model;
  final int? index;
  final formKey = GlobalKey<FormState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  var cancelReason = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  ViewInfoHandle({
    super.key,
    required this.model,
    this.index
  });

  @override
  Widget build(BuildContext context) {
    SecretariaLyoutCubit cubit = SecretariaLyoutCubit();
    return BlocProvider(
        create: (BuildContext context) => SecretariaLyoutCubit()..viewInfoHandle(id: model.appointment[index!].id),
        child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
          listener: (context, state) {
            if(state is cancelAppointmentSuccssesState)
            {
              Navigator.pop(context);
              CustomeSnackBar.showSnackBar(
                context,
                msg: 'Approved Succsses',
                color: Colors.green,
              );
            }
          },
          builder: (context, state) {
            if(state is ApppintmentListByDateErrorState)
            {
              return const Padding(
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
                        'There is some thing error',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else if (state is! ApppintmentListByDateLoadingState) {
              return Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  backgroundColor: defaultColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(20.r))),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 19.w,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: 20.w,
                      ),
                      child: const CustomArrowBackIconButton(),
                    ),
                  ],
                ),
                body: Container(
                  width: screenSize.width,
                  color: Colors.white,
                  padding: EdgeInsetsDirectional.all(10.h),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' Patient',
                                  style: TextStyle(
                                    color: defaultColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 3.w,
                                    end: 3.w,
                                    top: 3.h,
                                    bottom: 3.h,
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PatientProfile(userId: model.appointment[index!].patient.userId,index: index! < 0 ? 0 : index!,)),
                                      );
                                    },
                                    child: Material(
                                      shadowColor: Colors.grey.shade50,
                                      elevation: 2.0,
                                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                      color: Colors.white,
                                      child: Container(
                                        width: 150.w,
                                        height: 45.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade500
                                          ),
                                        ),
                                        padding: EdgeInsetsDirectional.only(
                                          start: 6.h,
                                          end: 6.h,
                                          top: 5.h,
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional.center,
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${model.appointment[index!].patient.user.firstName} ${model.appointment[index!].patient.user.lastName}',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Tap to see details',
                                                    style: TextStyle(
                                                      color: Colors.grey.shade500,
                                                      fontSize: 9.w,
                                                      fontWeight: FontWeight.w300
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' Doctor',
                                  style: TextStyle(
                                      color: defaultColor
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 3.w,
                                    end: 3.w,
                                    top: 3.h,
                                    bottom: 3.h,
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => DoctorProfile(indexApp: model.appointment[index!].id,userId: model.appointment[index!].doctor.userId,index: index! < 0 ? 0 : index!,)),
                                      );
                                    },
                                    child: Material(
                                      shadowColor: Colors.grey.shade50,
                                      elevation: 2.0,
                                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                      color: Colors.white,
                                      child: Container(
                                        width: 150.w,
                                        height: 45.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade500
                                          ),
                                        ),
                                        padding: EdgeInsetsDirectional.only(
                                          start: 6.h,
                                          end: 6.h,
                                          top: 5.h,
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional.center,
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${model.appointment[index!].doctor.user.firstName} ${model.appointment[index!].doctor .user.lastName}',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Tap to see details',
                                                    style: TextStyle(
                                                        color: Colors.grey.shade500,
                                                        fontSize: 9.w,
                                                        fontWeight: FontWeight.w300
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' Description',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 3.w,
                                end: 3.w,
                                top: 3.h,
                                bottom: 3.h,
                              ),
                              child: Material(
                                shadowColor: Colors.grey.shade50,
                                elevation: 2.0,
                                borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                color: Colors.white,
                                child: Container(
                                  width: screenSize.width,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade500
                                    ),
                                    //border: const Border.fromBorderSide(BorderSide.none),
                                  ),
                                  padding: EdgeInsetsDirectional.only(
                                    start: 6.h,
                                    end: 6.h,
                                    top: 5.h,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        model.appointment[index!].description,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' Appointment Info',
                              style: TextStyle(
                                color: defaultColor,
                                //fontSize: 13.h,
                                //fontWeight: FontWeight.w500
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 3.w,
                                end: 3.w,
                                top: 3.h,
                                bottom: 3.h,
                              ),
                              child: Material(
                                shadowColor: Colors.grey.shade50,
                                elevation: 2.0,
                                borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                color: Colors.white,
                                child: Container(
                                  width: screenSize.width,
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade500
                                    ),
                                    //border: const Border.fromBorderSide(BorderSide.none),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            start: 10.h,
                                            end: 10.h,
                                            top: 8.h,
                                          ),
                                          child: Align(
                                            alignment: AlignmentDirectional.topStart,
                                            child: Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                        top: 5.h,
                                                      ),
                                                      child: Icon(
                                                        Icons.date_range,
                                                        color: Colors.purple.shade300,
                                                        size: 27.w,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'date',
                                                          style: TextStyle(
                                                            color: Colors.grey.shade500,
                                                            fontSize: 13.w,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${model.appointment[index!].date}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13.w,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 110.w,
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                        top: 5.h,
                                                      ),
                                                      child: Icon(
                                                        Icons.watch_later_outlined,
                                                        color: Colors.purple.shade300,
                                                        size: 27.w,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'time',
                                                          style: TextStyle(
                                                            color: Colors.grey.shade500,
                                                            fontSize: 13.w,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text(
                                                          '${model.appointment[index!].time}'.replaceRange(5, 8, ''),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13.w,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional.bottomCenter,
                                        child: SizedBox(
                                          height: 1.h,
                                          child: Container(
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional.bottomStart,
                                        child: Container(
                                          height: 35.h,
                                          width: screenSize.width,
                                          decoration: BoxDecoration(
                                            border: Border.fromBorderSide(BorderSide.none),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: AlignmentDirectional.center,
                                                  child: TextButton(
                                                    onPressed: (){
                                                      cubit.approveTheAppointment(id: model.appointment[index!].id);
                                                    },
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 100.w,
                                                      alignment: AlignmentDirectional.center,
                                                      child: Text(
                                                        'Approve'
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 1.w,
                                                child: Container(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment: AlignmentDirectional.center,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      scaffoldKey.currentState!.showBottomSheet(
                                                        elevation: 00.0,
                                                            (context) => Container(
                                                          height: 270.h,
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
                                                                  child: Column(

                                                                    children: [
                                                                      RegisterTextField(
                                                                        lableText: 'Time',
                                                                        icon: Icons.watch_later,
                                                                        controller: timeController,
                                                                        keyboardType: TextInputType.text,
                                                                        onTap: (){
                                                                          showTimePicker(
                                                                            context: context,
                                                                            initialTime: TimeOfDay.now(),
                                                                          ).then((value) {
                                                                            timeController.text = value!.format(context).toString();
                                                                          });
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height * 0.02,
                                                                      ),
                                                                      RegisterTextField(
                                                                        lableText: 'Date',
                                                                        icon: Icons.date_range,
                                                                        controller: dateController,
                                                                        keyboardType: TextInputType.text,
                                                                        onTap: (){
                                                                          showDatePicker(
                                                                            context: context,
                                                                            initialDate: DateTime.now(),
                                                                            firstDate: DateTime.now(),
                                                                            lastDate: DateTime.parse('2024-02-08'),
                                                                          ).then((value) {
                                                                            //Tuesday Oct 03
                                                                            dateController.text = '${DateFormat.EEEE().format(value!)} ${DateFormat.MMMd().format(value!)}';
                                                                            print(dateController.text);
                                                                          });
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(context).size.height * 0.05,
                                                              ),
                                                              CustomeButton(
                                                                text: 'Edit',
                                                                width: 250.w,
                                                                borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                                                onPressed: (){
                                                                  if(formKey.currentState!.validate()){
                                                                    SecretariaLyoutCubit.get(context).handelApppintment(
                                                                      date: dateController.text,
                                                                      time: timeController.text,
                                                                      status: 'approve',
                                                                      id: model.appointment[index!].id,
                                                                    );
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
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 100.w,
                                                      alignment: AlignmentDirectional.center,
                                                      child: Text(
                                                        'Edit'
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 1.w,
                                                child: Container(
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment: AlignmentDirectional.center,
                                                  child: TextButton(
                                                    onPressed: () {
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
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 100.w,
                                                      alignment: AlignmentDirectional.center,
                                                      child: Text(
                                                        'Cancel',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const CustomeProgressIndicator();
            }
          },
        ),
    );
  }
}
