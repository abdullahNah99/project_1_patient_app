import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/core/widgets/custome_image.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_cubit.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';

import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/widgets/custome_arrow_back_button.dart';
import '../../../core/widgets/custome_button.dart';
import '../../../core/widgets/register_text_field.dart';

class RegisterSecretaria extends StatelessWidget {
  static const route = 'RegisterSecretaria';

  static var firstName = TextEditingController();
  static var lastName = TextEditingController();
  static var phoneNum = TextEditingController();
  static var email = TextEditingController();
  static var address = TextEditingController();
  static var pass = TextEditingController();
  static var birthDate = TextEditingController();
  static var gender = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  RegisterSecretaria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SecretariaLyoutCubit(),
      child: BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
        listener: (context, state) {
          if(state is PatientRegisterSuccssesState){
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Add Succsses',
              color: Colors.green,
            );
            SecretariaLyoutCubit.get(context).indexPatientsList();
            Navigator.pop(context);
            firstName.clear();
            lastName.clear();
            phoneNum.clear();
            address.clear();
            email.clear();
            pass.clear();
            birthDate.clear();
            gender.clear();
          }
          if(state is PatientRegisterErrorState){
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Add Failed',
              color: Colors.red,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
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
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 10.w,
                    end: 10.w,
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomeImage(
                        image: AppAssets.defaultImagePurple,
                        width: MediaQuery.of(context).size.height * .2,
                        height: MediaQuery.of(context).size.height * .2,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      RegisterTextField(
                        lableText: 'First Name',
                        icon: Icons.person,
                        controller: firstName,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      RegisterTextField(
                        lableText: 'Last Name',
                        icon: Icons.person,
                        controller: lastName,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      RegisterTextField(
                        lableText: 'Phone Number',
                        icon: Icons.phone,
                        controller: phoneNum,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      RegisterTextField(
                        lableText: 'Address',
                        icon: Icons.location_on,
                        controller: address,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      RegisterTextField(
                        lableText: 'Email',
                        icon: Icons.mail,
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      RegisterTextField(
                        lableText: 'Password',
                        icon: Icons.lock,
                        controller: pass,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'the password must be at least 6 characters';
                          }
                          return null;
                        },
                        obscureText: SecretariaLyoutCubit.get(context).isPassShow,
                        suffixIcon: SecretariaLyoutCubit.get(context).suffixIcon,
                        onPressed: (){
                          SecretariaLyoutCubit.get(context).changePassVisibility();
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      RegisterTextField(
                        lableText: 'Birth Date',
                        icon: Icons.cake,
                        controller: birthDate,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      RegisterTextField(
                        lableText: 'Gender',
                        icon: CupertinoIcons.person_2_fill,
                        controller: gender,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      CustomeButton(
                        text: 'Next',
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            SecretariaLyoutCubit.get(context).registerPatient(
                              first_name: firstName.text,
                              last_name: lastName.text,
                              phone_num: phoneNum.text,
                              address: address.text,
                              email: email.text,
                              password: pass.text,
                              birth_date: birthDate.text,
                              gender: gender.text,
                              FCMToken: 'kmhgfcn',
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}