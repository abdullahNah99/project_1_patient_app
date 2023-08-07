import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/main.dart';

import '../../../core/widgets/register_text_field.dart';
import '../api_cubit/api_cubit.dart';
import '../api_cubit/api_states.dart';

class HandelApppintment extends StatelessWidget {

  static const route = 'HandelApppintment';

  static var scaffoldKey = GlobalKey<ScaffoldState>();
  static var timeController = TextEditingController();
  static var dateController = TextEditingController();
  static var reasonController = TextEditingController();


  HandelApppintment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SecretariaLyoutCubit(),
      child: BlocConsumer<SecretariaLyoutCubit, SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: Column(
              children: [
                RegisterTextField(
                  lableText: 'Time',
                  icon: Icons.person,
                  controller: timeController,
                  keyboardType: TextInputType.text,
                  onTap: (){
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      timeController.text = value!.format(context).toString();
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                RegisterTextField(
                  lableText: 'Date',
                  icon: Icons.person,
                  controller: dateController,
                  keyboardType: TextInputType.text,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2024-02-08'),
                    ).then((value) {
                      dateController.text = DateFormat.yMMMd().format(value!);
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                RegisterTextField(
                  lableText: 'Reason',
                  icon: Icons.person,
                  controller: reasonController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                  ),
                  width: MediaQuery.of(context).size.width * .3,
                  child: IconButton(
                    onPressed: () {
                      SecretariaLyoutCubit.get(context).handelApppintment(
                        date: dateController.text,
                        time: timeController.text,
                        status: 'approve', id: 5,
                      );
                      timeController.clear();
                      dateController.clear();
                      reasonController.clear();
                    },
                    icon: Icon(
                      Icons.check,
                      size: 30.w,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
