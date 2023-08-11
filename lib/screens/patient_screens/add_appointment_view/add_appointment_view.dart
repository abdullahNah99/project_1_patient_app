import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/functions/custome_dialogs.dart';
import 'package:patient_app/core/models/doctor_model.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/widgets/custome_button.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/patient_screens/add_appointment_view/widgets/custom_app_bar.dart';
import 'package:patient_app/screens/patient_screens/add_appointment_view/widgets/dates_list_view.dart';
import 'package:patient_app/screens/patient_screens/add_appointment_view/widgets/times_buttons_section.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/functions/custome_snack_bar.dart';
import 'cubit/add_appointment_cubit.dart';
import 'cubit/add_appointment_states.dart';

class AddAppointmentView extends StatelessWidget {
  static const route = 'AddAppointmentView';

  const AddAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)?.settings.arguments;
    final DoctorModel doctorModel = args[0];
    final PatientModel patientModel = args[1];
    return BlocProvider(
      create: (context) {
        return AddAppointmentCubit()
          ..fetchDoctorTimes(doctorModel: doctorModel);
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: AddAppointmentViewBody(
              doctorModel: doctorModel,
              patientModel: patientModel,
            ),
          ),
        ),
      ),
    );
  }
}

class AddAppointmentViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  final PatientModel patientModel;
  const AddAppointmentViewBody({
    super.key,
    required this.doctorModel,
    required this.patientModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAppointmentCubit, AddAppointmentStates>(
      listener: (context, state) {
        if (state is AddAppointmentSuccessState) {
          CustomeSnackBar.showSnackBar(
            context,
            msg: 'Appointment Added Successfully',
            color: Colors.green,
            fontSize: 16.sp,
          );
          SchedulerBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<AddAppointmentCubit>(context).close();
            Navigator.popUntil(context, (route) => route.isFirst);
          });
        } else if (state is AddAppointmentFailureState) {
          CustomeSnackBar.showErrorSnackBar(context, msg: state.failureMsg);
        }
      },
      builder: (context, state) {
        if (state is AddAppointmentLodgingState) {
          return const CustomeProgressIndicator();
        } else {
          return _Body(
            key: key,
            doctorModel: doctorModel,
            patientModel: patientModel,
          );
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final DoctorModel doctorModel;
  final PatientModel patientModel;
  const _Body({
    super.key,
    required this.doctorModel,
    required this.patientModel,
  });

  @override
  Widget build(BuildContext context) {
    AddAppointmentCubit cubit = BlocProvider.of<AddAppointmentCubit>(
      context,
      listen: false,
    );
    cubit.createDatesList();
    return Stack(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          color: defaultColor,
        ),
        Column(
          children: [
            SizedBox(
              height: 200.h,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(doctorModel: doctorModel),
                    const Spacer(),
                    DatesListView(
                      addAppointmentCubit: cubit,
                      key: key,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TimesButtons(addAppointmentCubit: cubit),
                        // cubit.times11.length < 6
                        //     ?
                        SizedBox(
                          height: 10.h,
                        ),
                        Form(
                          key: cubit.formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'required';
                              }
                              return null;
                            },
                            maxLines: 3,
                            controller: cubit.discretionController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              hintText: "Description . . .",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: defaultColor.withOpacity(.6)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomeButton(
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              if (cubit.addAppointmentModel.date == null) {
                                CustomeSnackBar.showSnackBar(
                                  context,
                                  msg: 'Please Select a Day',
                                  color: Colors.red,
                                );
                              } else if (cubit.addAppointmentModel.time ==
                                  null) {
                                CustomeSnackBar.showSnackBar(
                                  context,
                                  msg: 'Please Select a Time',
                                  color: Colors.red,
                                );
                              } else if (patientModel.wallet! < 100) {
                                CustomeSnackBar.showSnackBar(
                                  context,
                                  msg:
                                      "You Don't Have Enough Money, Please Charge Your Wallet",
                                  color: Colors.red,
                                );
                              } else {
                                CustomDialogs.showCustomDialog(
                                  context,
                                  balance: patientModel.wallet!,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    cubit.addAppointment(
                                      token: CacheHelper.getData(key: 'Token'),
                                      departmentID: doctorModel.departmentID,
                                      doctorID: doctorModel.id,
                                    );
                                  },
                                );
                              }
                            }
                            log(patientModel.wallet.toString());
                          },
                          text: 'ADD',
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
