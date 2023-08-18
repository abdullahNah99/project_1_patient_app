import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/utils/constants.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/styles/app_colors.dart';
import '../widget/custom_button.dart';
import 'cubit/session_cubit.dart';

class UpdateSessionScreen extends StatelessWidget
{
  GetPatientAndSessionSuccess state;
  var medicineController = TextEditingController();
  var reportController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  //final int appointmentId ;
  int index;
  //int appointmentId;

  UpdateSessionScreen(this.state,this.index,
     // this.appointmentId
      );

  @override
  Widget build(BuildContext context) {
    int sessionId = state.session[index].id!;
    int appointmentId = state.session[index].appointmentId!;
    int patientId = state.patient[index].id!;

    medicineController.text = state.session[index].medicine!;
    reportController.text = state.session[index].report!;
    var image = NetworkImage('${Constants.baseURL}upload/${state.session[index].image_path}');
    return BlocProvider(
        create: (context) => SessionCubit(),
        child: BlocConsumer<SessionCubit,SessionStates>(
          builder: (context,state)
          {

            SessionCubit cubit =  SessionCubit.get(context);
            var imageOfSession  =  SessionCubit.get(context).imageOfSession;
            return Scaffold(
              appBar: AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.r),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                    [
                      Container(
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
                                  controller: medicineController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter a medicine',
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
                                  onFieldSubmitted: (String value)
                                  {

                                  },
                                  onChanged: (String value)
                                  {
                                    print(value);
                                  },
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
                                TextFormField(
                                  maxLines: 1,
                                  autofocus: true,
                                  cursorColor: defaultColor,
                                  controller: reportController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter a report',
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
                                  onFieldSubmitted: (String value)
                                  {

                                  },
                                  onChanged: (String value)
                                  {
                                    print(value);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'field mustn\'t be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:Align(
                                    child:Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children:
                                      [
                                        Container(
                                          width: double.infinity,
                                          height: 170.0,
                                          child: image == null ? Center(child: Text('no image',style: TextStyle(color: Colors.grey, fontSize: 14.0),),) :  Image.file(
                                            File('${imageOfSession}').absolute,
                                            fit: BoxFit.cover,
                                          ),

                                        ),

                                        CircleAvatar(
                                          backgroundColor: defaultColor,
                                          radius: 18.0,
                                          child:IconButton(
                                            onPressed: ()
                                            {
                                              cubit.getImage();
                                            },
                                            icon:const Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 20.0,
                                            ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                defButton(
                                    width: 170.w,
                                    function: ( )
                                    {
                                      if(formKey.currentState!.validate())
                                      {
                                        /*SessionCubit.get(context).updateWithImage(
                                            sessionId: sessionId,
                                            endPoint: 'session/update/',
                                            body:
                                            {
                                              'medicine': medicineController.text,
                                              'report': reportController.text,
                                             // 'appointment_id':'$appointmentId',
                                            },
                                            imagePath: '${imageOfSession}',
                                            token:CacheHelper.getData(key: 'Token'));*/


                                        SessionCubit.get(context).updateSession(
                                          context,
                                            token:CacheHelper.getData(key: 'Token') ,
                                            appointmentId: appointmentId ,
                                            medicine:medicineController.text ,
                                            report:reportController.text ,
                                            sessionId:sessionId ,);

                                        print(sessionId);
                                        print(appointmentId);
                                        print(patientId);


                                        Navigator.pop(context);
                                        SessionCubit.get(context).getPatientAndSession(token: CacheHelper.getData(key: 'Token'), patientId: patientId);

                                      }

                                    },
                                    text: 'update',
                                    radius: 25.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context,state){},
        ));
  }
}