import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consult_doctor_cubit/cubit.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consult_doctor_cubit/states.dart';
import '../../../core/models/doctor_model.dart';
import '../widget/custom_button.dart';
import '../widget/custom_navigate.dart';
import 'consulting_screen.dart';

class PostAnswerScreen extends StatelessWidget {


  String? answer;
  final int consultId;
  PostAnswerScreen({required this.consultId});
  var answerController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => DoctorConsultCubit(),
    child: BlocBuilder<DoctorConsultCubit, DoctorConsultStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Post Answer'),
          ),
          body: Padding(
            padding:const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        maxLines: 1,
                        autofocus: true,
                        cursorColor: defaultColor,
                        controller: answerController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Enter your answer',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: defaultColor,
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        /*onFieldSubmitted: (String value)
                        {
                          print(value);
                        },*/
                        onChanged: (value) => answer = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'field mustn\'t be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      defButton(
                          width: 170.w,
                          function: ( )
                          {
                            // log('${doctorModel.id}');
                            if(formKey.currentState!.validate())
                            {
                               DoctorConsultCubit.get(context).addAnswer(
                                 context,
                                 consultationID: consultId,
                                 answer: answer!,
                              );

                               Navigator.pop(context);
                               DoctorConsultCubit.get(context).getQuestion();
                              // navigateAndReplacement(context,ShowConsultingScreen());
                            }

                          },
                          text: 'Send',
                          radius: 25.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

        );
      },
    ),) ;
  }
}
