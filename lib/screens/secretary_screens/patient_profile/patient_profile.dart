import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_arrow_back_button.dart';
import '../api_cubit/api_cubit.dart';
import '../api_cubit/api_states.dart';
import 'widgets/patient_profile_item.dart';

class PatientProfile extends StatelessWidget {

  static const route = 'PatientProfile';

  final int userId;
  final int? index;

  const PatientProfile({
    super.key,
    required this.userId,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SecretariaLyoutCubit()..viewPatient(user_id: userId),
      child: BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is PatientProfErrorState)
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
              condition: state is! PatientProfLoadingState,
              builder: (context) => PatientProfileItem(model: SecretariaLyoutCubit.get(context).viewPatientModel,),
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