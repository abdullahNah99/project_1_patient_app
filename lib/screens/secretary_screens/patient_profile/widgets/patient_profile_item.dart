import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/widgets/custome_button.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';
import '../../../../core/functions/custome_snack_bar.dart';
import '../../../../core/models/secretaria/secretaria_patient/view_patient_model.dart';
import '../../../../core/widgets/custome_arrow_back_button.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../../../core/widgets/register_text_field.dart';
import '../../../../main.dart';
import '../../api_cubit/api_cubit.dart';
import 'default_text_info.dart';


class PatientProfileItem extends StatelessWidget {

  final ViewPatientModel? model;
  final formKey = GlobalKey<FormState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  var amount = TextEditingController();

  PatientProfileItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
      listener: (context, state) {
        if(state is ChargeWalletSuccssesState){
          Navigator.pop(context);
          CustomeSnackBar.showSnackBar(
            context,
            msg: 'Charge Succsses',
            color: Colors.green,
          );
        }else if(state is ChargeWalletErrorState){
          CustomeSnackBar.showSnackBar(
            context,
            msg: 'Charge Failed',
            color: Colors.red,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          body: Stack(
            children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                color: defaultColor,
              ),
              Positioned(
                left: screenSize.width * .85,
                top: 22.h,
                child: const CustomArrowBackIconButton(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    top: 180.h,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultTextInfo(
                          caption: 'Address',
                          text: model!.patient.address,
                          icon: Icons.location_on,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        DefaultTextInfo(
                          caption: 'Email',
                          text: model!.patient.user.email,
                          icon: Icons.mail,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        DefaultTextInfo(
                          caption: 'Phone number',
                          text: model!.patient.user.phoneNum,
                          icon: Icons.call,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        DefaultTextInfo(
                          caption: 'Date of birth',
                          text: model!.patient.birthDate,
                          icon: Icons.cake,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        DefaultTextInfo(
                          caption: 'Gender',
                          text: model!.patient.gender,
                          icon: CupertinoIcons.person_2_fill,
                        ),
                      ],
                    ),
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
                        CustomeImage(
                          borderRadius: BorderRadius.circular(50.h),
                          margin: EdgeInsets.only(top: screenSize.height * .16),
                          height: 100.h,
                          width: 95.h,
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Text(
                      '${model!.patient.user.firstName} ${model!.patient.user.lastName}',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    CustomeButton(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                        width: 250.w,
                        text: 'charge Wallet',
                        onPressed: (){
                          scaffoldKey.currentState!.showBottomSheet(
                            elevation: 00.0,
                                (context) => Container(
                              height: 175.h,
                              width: screenSize.width,
                              color: Colors.grey.shade100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.020,
                                  ),
                                  Form(
                                    key: formKey,
                                    child: Padding(
                                      padding:  EdgeInsetsDirectional.only(
                                        start: 10.w,
                                        end: 0.w,
                                      ),
                                      child: RegisterTextField(
                                        lableText: 'Amount',
                                        icon: Icons.monetization_on,
                                        controller: amount,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.05,
                                  ),
                                  CustomeButton(
                                    text: 'Charge',
                                    width: 250.w,
                                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        SecretariaLyoutCubit.get(context).chargeWallet(value: double.parse(amount.text), id: model!.patient.id);
                                        SecretariaLyoutCubit.get(context).changeBottomSheet(isShow: true);
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.033,
                                  ),
                                ],
                              ),
                            ),
                          ).closed.then((value) => {
                            SecretariaLyoutCubit.get(context).changeBottomSheet(isShow: false),
                          }
                          );
                        }
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.033,
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        '   Personal Information',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 13.h,
                          fontWeight: FontWeight.w500,
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