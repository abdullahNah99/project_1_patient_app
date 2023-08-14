import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/secretary_screens/secretary_profile/widgets/secretary_profile_item.dart';

import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_arrow_back_button.dart';
import '../api_cubit/api_cubit.dart';
import '../api_cubit/api_states.dart';

class SecretaryProfile extends StatelessWidget {

  final int userId;

  const SecretaryProfile({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SecretariaLyoutCubit()..viewSecretary(user_id: userId),
      child: BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
          if(state is SecretariaProfErrorState)
          {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: defaultColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(20.r))),
                automaticallyImplyLeading: false,
                leading: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 16.w,
                    top: 8.5.w,
                    bottom: 8.5.w,
                  ),
                  child: const CustomArrowBackIconButton(),
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
              body: Center(
                child: Text(
                  'There is some thing error',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            );
          }else
          {
            return ConditionalBuilder(
              condition: state is! SecretariaProfLoadingState,
              builder: (context) => SecretaryProfileItem(model: cubit.viewSecretaryModel,),
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