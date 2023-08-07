import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/secretary_screens/doctor_profile/widgets/doctor_profile_item.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_arrow_back_button.dart';
import '../api_cubit/api_cubit.dart';
import '../api_cubit/api_states.dart';

class DoctorProfile extends StatelessWidget {

  static const route = 'PatientProfile';

  final int userId;
  final int? index;
  final int indexApp;

  const DoctorProfile({
    super.key,
    required this.userId,
    this.index,
    required this.indexApp,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SecretariaLyoutCubit()..viewDoctor(user_id: userId)..viewInfoHandle(id: indexApp),
      child: BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is DoctorProfErrorState || state is viewInfoHandleModelErrorState)
          {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: defaultColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(20.r))),
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: 20.w,
                    ),
                    child: const CustomArrowBackIconButton(),
                  ),
                ],
              ),
              body: const Center(
                child: Text(
                  'There is some thing error',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }else
          {
            return ConditionalBuilder(
              condition: state is! DoctorProfLoadingState && state is! viewInfoHandleModelLoadingState,
              builder: (context) => state is viewInfoHandleModelSuccssesState ? DoctorProfileItem(
                  model: SecretariaLyoutCubit.get(context).viewDoctorModel,
                  modelInfo: SecretariaLyoutCubit.get(context).viewInfoHandleModel)
                  : Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(child: Text('Please Wait...'),),),
              fallback: (context) => Container(
                color: Colors.white,
                child:  const Center(child: CircularProgressIndicator(),),
              ),
            );
          }
        },
      ),
    );
  }
}
