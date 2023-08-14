import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';

import '../../../core/styles/app_colors.dart';
import '../add_patient/add_patient.dart';
import '../api_cubit/api_cubit.dart';
import 'widgets/patients_list_view_item.dart';

class PatientList extends StatelessWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
      listener: (context, state) {
        /*if(state is PatientRegisterSuccssesState)
        {
          SecretariaLyoutCubit.get(context).indexPatient();
        }*/
      },
      builder: (context, state) {
        if(state is PatientListErrorState)
        {
          return Padding(
            padding: const EdgeInsetsDirectional.only(
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
                    style:Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Material(
                  color: Colors.white,
                  elevation: 10.0,
                  shadowColor: Colors.grey.shade100,
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(30.0)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .14,
                    height: MediaQuery.of(context).size.height * .07,
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context, RegisterSecretaria.route);
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddPatient()),
                              );*/
                            //navigateAndReplacement(context, RegisterSecretaria());
                          },
                          icon: const Icon(
                            Icons.add,
                            color: defaultColor,
                            size: 29.0,
                          )),
                    ),
                  ),
                )
              ],
            ),
          );
        }else if(state is PatientListLoadingState)
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
            child: SizedBox(
              height: screenSize.height,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children:[
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          PatientsListViewItem(context,profImage: AppAssets.defaultImage, model: SecretariaLyoutCubit.get(context).indexPatientModel,),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: 1.5.w,
                      bottom: 5.h,
                    ),
                    child: Material(
                      color: Colors.white,
                      elevation: 10.0,
                      shadowColor: Colors.grey.shade100,
                      borderRadius: const BorderRadiusDirectional.all(Radius.circular(30.0)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .14,
                        height: MediaQuery.of(context).size.height * .07,
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context, RegisterSecretaria.route
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                color: defaultColor,
                                size: 29.0,
                              )),
                        ),
                      ),
                    ),
                  )
                ]
              ),
            ),
          );
        }
      },
    );
  }
}
