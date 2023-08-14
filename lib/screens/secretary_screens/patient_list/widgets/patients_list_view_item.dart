import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';

import '../../../../core/models/secretaria/secretaria_patient/index_patient_model.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../api_cubit/api_cubit.dart';
import '../../patient_profile/patient_profile.dart';

class PatientsListViewItem extends StatelessWidget {

  final String? profImage;
  final IndexPatientModel model;


  const PatientsListViewItem(
      BuildContext? context, {
        super.key,
        this.profImage,
        required this.model,
      });


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! PatientListLoadingState,
            builder: (context) => model.patient.isNotEmpty ?
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
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
                        MaterialPageRoute(builder: (context) => PatientProfile(userId: model.patient[index].userId,index: index < 0 ? 0 : index,)),
                      );
                    },
                    child: Material(
                      shadowColor: Colors.grey.shade50,
                      elevation: 5.0,
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                      color: Colors.white,
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                          border: const Border.fromBorderSide(BorderSide.none),
                        ),
                        padding: EdgeInsetsDirectional.only(
                          start: 6.h,
                          end: 6.h,
                          top: 5.h,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            children: [
                              CustomeImage(
                                image: AppAssets.defaultImagePurple ,
                                width: 145.w,
                                //height: 150.h,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Container(
                                height: .6.h,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(
                                height: 8.w,
                              ),
                              Expanded(
                                child: Text(
                                  '${model.patient[index].user.firstName} ${model.patient[index].user.lastName}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.w,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5.w,
                              ),
                              Expanded(
                                child: Text(
                                  model.patient[index].user.phoneNum,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13.w,
                                      fontWeight: FontWeight.w400
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 5.h,
                  childAspectRatio: 3/2,
                  mainAxisExtent: 260.h
                ),
                itemCount: model.patient.length,
              )
                : const Center(),
            fallback: (context) => const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }
}

/*ListView.separated(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  GestureDetector(
                    onTap: (){
                      *//*SecretariaLyoutCubit.get(context).viewPatient(
                        user_id: model.patient[index].userId,
                      );*//*
                      *//*Navigator.pushNamed(
                          context, PatientProfile.route
                      );*//*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PatientProfile(model: model,index: index < 0 ? 0 : index,)),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .14,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 12.5,
                          //end: 8.0,
                          bottom: 12.5,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: const BorderRadiusDirectional.all(Radius.circular(10.0))
                          ),
                          padding: const EdgeInsetsDirectional.only(
                            start: 7.0,
                          ),
                          child: Row(
                            children: [
                              CustomeImage(
                                image: AppAssets.defaultImagePurple,
                                width: MediaQuery.of(context).size.height * .08,
                                height: MediaQuery.of(context).size.height * .08,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 10.0,
                                    top: 15.0,
                                    bottom: 0.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${model.patient[index].user.firstName} ${model.patient[index].user.lastName}',
                                          style: const TextStyle(
                                            color: defaultColor,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          model.patient[index].user.phoneNum,
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                  ),
              separatorBuilder: (context, index) => SizedBox(
                height: MediaQuery.of(context).size.height * .0,
              ),
              itemCount: model.patient.length,
            )*/