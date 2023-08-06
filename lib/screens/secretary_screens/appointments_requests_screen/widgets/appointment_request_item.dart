import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_cubit.dart';
import '../../../../core/models/appointment_model.dart';
import '../../../../core/models/secretaria/secretaria_appointment/index_appointment_by_date_model.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../api_cubit/api_states.dart';
import '../../handel_apppintment/handel_apppintment.dart';
import '../../view_info_handle/view_info_handle.dart';

class AppointmentRequestItem extends StatelessWidget {

  //final List<AppointmentModel> appointments;
  final int? index;
  final IndexAppointmentByDateModel model;

  const AppointmentRequestItem({
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
                      Spacer(),
                      _HandleButton(model: model, index: index! < 0 ? 0 : index!,),
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
  final IndexAppointmentByDateModel model;

  const _HandleButton({
    this.index,
    required this.model,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context1) => ViewInfoHandle(model: model,index: index! < 0 ? 0 : index!,)),
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
                'Handle',
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
