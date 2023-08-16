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
import '../../../core/widgets/custome_arrow_back_button.dart';
import '../../../core/widgets/custome_button.dart';
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
    return BlocProvider(
        create: (BuildContext context) => SecretariaLyoutCubit()..viewInfoHandle(id: model.appointment[index!].id),
        child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
          listener: (context, state) {
            if(state is ApproveTheAppointmentSuccssesState)
            {
              CustomeSnackBar.showSnackBar(
                context,
                msg: 'Approve Succsses',
                color: Colors.green,
              );
              Navigator.pop(context);
            }else if(state is ApproveTheAppointmentErrorState)
            {
              CustomeSnackBar.showSnackBar(
                context,
                msg: 'Approve Failed',
                color: Colors.red,
              );
              //Navigator.pop(context);
            }
            if(state is HandelApppintmentSuccssesState)
            {
              Navigator.pop(context);
              CustomeSnackBar.showSnackBar(
                context,
                msg: 'Edit Succsses',
                color: Colors.green,
              );
              Navigator.pop(context);
            }else if(state is HandelApppintmentErrorState)
            {
              Navigator.pop(context);
              CustomeSnackBar.showSnackBar(
                context,
                msg: 'Edit Failed',
                color: Colors.red,
              );
              //Navigator.pop(context);
            }
            if(state is DeleteAppointmentSuccssesState)
            {
              CustomeSnackBar.showSnackBar(
                context,
                msg: 'Delete Succsses',
                color: Colors.green,
              );
              Navigator.pop(context);
            }else if(state is DeleteAppointmentErrorState)
            {
              CustomeSnackBar.showSnackBar(
                context,
                msg: 'Delete Failed',
                color: Colors.red,
              );
              //Navigator.pop(context);
            }
          },
          builder: (context, state) {
            SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
            if(state is ApppintmentListByDateErrorState)
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
                        'There is some thing error',
                        style: Theme.of(context).textTheme.labelLarge,
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
                  leading: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      top: 8.5.w,
                      bottom: 8.5.w,
                    ),
                    child: const CustomArrowBackIconButton(),
                  ),
                  title: const Text(
                    'Details',
                  ),
                  /*actions: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: 20.w,
                      ),
                      child: const CustomArrowBackIconButton(),
                    ),
                  ],*/
                ),
                body: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  //color: Colors.white,
                  padding: EdgeInsetsDirectional.all(10.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w400,
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
                                                    style: Theme.of(context).textTheme.titleSmall,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Tap to see details',
                                                    style: Theme.of(context).textTheme.labelSmall,
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
                                    color: defaultColor,
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w400,
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
                                                    style: Theme.of(context).textTheme.titleSmall,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Tap to see details',
                                                    style: Theme.of(context).textTheme.labelSmall,
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
                                fontSize: 13.w,
                                fontWeight: FontWeight.w400,
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
                                        style: Theme.of(context).textTheme.titleSmall,
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
                                fontSize: 13.w,
                                fontWeight: FontWeight.w400,
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
                                                          model.appointment[index!].date,
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
                                                  width: 65.w,
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
                                                          model.appointment[index!].time.replaceRange(5, 8, ''),
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
                                          decoration: const BoxDecoration(
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
                                                      child: const Text(
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
                                                                        hintText: 'Time ...',
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
                                                                        hintText: 'Date ...',
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
                                                                            dateController.text = '${DateFormat.EEEE().format(value!)} ${DateFormat.MMMd().format(value)}';
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
                                                                    cubit.handelApppintment(
                                                                      date: dateController.text,
                                                                      time: timeController.text,
                                                                      status: 'approve',
                                                                      id: model.appointment[index!].id,
                                                                    );
                                                                    cubit.changeBottomSheet(isShow: true);
                                                                    //SecretariaLyoutCubit.get(context).viewInfoHandle(id: model.appointment[index!].id);
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
                                                        cubit.changeBottomSheet(isShow: false),
                                                      }
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 100.w,
                                                      alignment: AlignmentDirectional.center,
                                                      child: const Text(
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
                                                      cubit.deleteAppointment(id: model.appointment[index!].id);
                                                    },
                                                    child: Container(
                                                      height: 35.h,
                                                      width: 100.w,
                                                      alignment: AlignmentDirectional.center,
                                                      child: const Text(
                                                        'Delete',
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
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' Booked Appointment',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 13.w,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .063,
                              padding: EdgeInsetsDirectional.only(
                                top: 3.h,
                                //bottom: 3.h,
                              ),
                              child: state is! ViewInfoHandleLoadingState ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => Material(
                                  shadowColor: Colors.grey.shade50,
                                  elevation: 2.0,
                                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .28,
                                    height: MediaQuery.of(context).size.height * .1,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade500
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        top: 6.h,
                                        bottom: 6.h,
                                        start: 12.w,
                                        end: 12.w,
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional.topStart,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            /*Text(
                                              cubit.viewInfoHandleModel.bookedAppointments[index].date,
                                              style: TextStyle(
                                                color: defaultColor,
                                                fontSize: 15.w,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),*/
                                            Text(
                                              cubit.viewInfoHandleModel.bookedAppointments[index].time,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.5.w,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: MediaQuery.of(context).size.width * .03,
                                ),
                                itemCount: cubit.viewInfoHandleModel.bookedAppointments.length,
                              )
                                  : state is ViewInfoHandleErrorState ? Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      start: 15.0,
                                      end: 15.0,
                                      top: 10.0,
                                      bottom: 10.0,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'There are no booked appointment',
                                        style: Theme.of(context).textTheme.labelLarge,
                                      ),
                                    ),
                                  )
                                      : const Center(child: CircularProgressIndicator()),
                            )
                          ],
                        ),
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

/*
GridView.builder(
  scrollDirection: Axis.horizontal,
  physics: const BouncingScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 5.w,
      mainAxisSpacing: 5.h,
      childAspectRatio: 3/2,
      mainAxisExtent: 99.h
  ),
  itemBuilder: (context, index) => Material(
    shadowColor: Colors.grey.shade50,
    elevation: 2.0,
    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
    child: Container(
      width: MediaQuery.of(context).size.width * .28,
      height: MediaQuery.of(context).size.height * .1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
        border: Border.all(
            width: 1,
            color: Colors.grey.shade500
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: 6.h,
          start: 12.w,
          end: 12.w,
        ),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*Text(
              cubit.viewInfoHandleModel.bookedAppointments[index].date,
              style: TextStyle(
                color: defaultColor,
                fontSize: 15.w,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 5.h,
            ),*/
              Text(
                cubit.viewInfoHandleModel.bookedAppointments[index].time,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.5.w,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ),
  ),
  itemCount: cubit.viewInfoHandleModel.bookedAppointments.length,
)
 */
