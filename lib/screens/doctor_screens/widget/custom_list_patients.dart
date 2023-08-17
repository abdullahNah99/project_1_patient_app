
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_image.dart';
import '../home_doctor_screen/home_doctor_cubit/home_cubit.dart';
import 'custom_divider.dart';

Widget listOfPatient(GetPatientsSuccessState state) => ListView.separated(
  itemBuilder: (context,index)=> patientItemBuilder(context,state,index ),
  separatorBuilder:(context,index)=> myDivider(),
  itemCount: state.patient.length,
);

Widget patientItemBuilder(BuildContext context,GetPatientsSuccessState state ,int index) => Padding(
  padding: const EdgeInsets.only(left: 5.0,right: 5.0,top: 10.0,bottom: 10.0),
  child: MaterialButton(
    onPressed: () {},
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
            image:
            'assets/images/undraw_Coffee_Time_e8cw.png',
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