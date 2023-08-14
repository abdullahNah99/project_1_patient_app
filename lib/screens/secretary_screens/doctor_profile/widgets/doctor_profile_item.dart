import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/secretaria/secretaria_appointment/view_info_handle_model.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';
import '../../../../core/models/secretaria/secretaria_doctor/view_doctor_model.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custome_arrow_back_button.dart';
import '../../../../main.dart';
import '../../api_cubit/api_cubit.dart';
import '../../patient_profile/widgets/default_text_info.dart';


class DoctorProfileItem extends StatelessWidget {

  final ViewDoctorModel? model;
  final ViewInfoHandleModel? modelInfo;

  const DoctorProfileItem({
    super.key,
    required this.model,
    required this.modelInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                color: defaultColor,
              ),
              Positioned(
                right: screenSize.width * .85,
                top: 22.h,
                child: const CustomArrowBackIconButton(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    top: 120.h,
                    bottom: 10.h,
                    start: 8.h,
                    end: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(25.r),
                    ),
                  ),
                  height: screenSize.height * .75,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTextInfo(
                        caption: 'Email',
                        text: model!.doctor.user.email,
                        icon: Icons.mail,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      DefaultTextInfo(
                        caption: 'Phone number',
                        text: model!.doctor.user.phoneNum,
                        //text: modelInfo!.appointment.doctor.workTimes[0].day,
                        icon: Icons.call,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Work Times',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 13.w,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 3.h,
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .13,
                              child: modelInfo!.appointment.doctor.workTimes.isNotEmpty ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => Material(
                                  shadowColor: Colors.grey.shade50,
                                  elevation: 2.0,
                                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .4,
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
                                            Text(
                                              modelInfo!.appointment.doctor.workTimes[index].day,
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
                                            ),
                                            Text(
                                              'From: ${modelInfo!.appointment.doctor.workTimes[index].startTime}'.replaceRange(11, 14, ''),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.5.w,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              'To:      ${modelInfo!.appointment.doctor.workTimes[index].endTime}'.replaceRange(9, 12, ''),
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
                                itemCount: modelInfo!.appointment.doctor.workTimes.length,
                              )
                              : Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 15.0,
                                  end: 15.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Center(
                                  child: Text(
                                    'There are no work times',
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        Container(
                          height: MediaQuery.of(context).size.height * .14,
                          width: MediaQuery.of(context).size.width * .27,
                          margin: EdgeInsets.only(top: screenSize.height * .16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(50.h),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${Constants.paseUrl}upload/${model!.doctor.imagePath}',
                              ),
                            )
                          ),
                        ),
                        /*CustomeImage(
                          //image: Image(image: NetworkImage('')),
                          borderRadius: BorderRadius.circular(50.h),
                          margin: EdgeInsets.only(top: screenSize.height * .16),
                          height: 100.h,
                          width: 95.h,
                        ),*/
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Text(
                      '${model!.doctor.user.firstName} ${model!.doctor.user.lastName}',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.033,
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        '   Contact Information',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 13.h,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
