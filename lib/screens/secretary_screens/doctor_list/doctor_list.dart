import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';

import '../api_cubit/api_cubit.dart';
import 'widgets/doctor_list_view_item.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
        if(state is SecretariaProfErrorState)
        {
          return Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 15.0,
              end: 15.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Center(
              child: Text(
                'There is some thing error',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          );
        }else  if(state is SecretariaProfLoadingState)
        {
          return const Center(child: CircularProgressIndicator());
        }else
        {
          return Padding(
            padding: EdgeInsetsDirectional.only(
              start: 5.w,
              end: 5.w,
              top: 8.h,
              bottom: 0.h,
            ),
            child: DoctorListViewItem(context,profImage: AppAssets.defaultImage, departmentId: cubit.viewSecretaryModel.secretary.departmentId,),
          );
        }
      },
    );
  }
}
