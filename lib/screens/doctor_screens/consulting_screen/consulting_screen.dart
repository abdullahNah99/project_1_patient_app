import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consult_doctor_cubit/cubit.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/consult_doctor_cubit/states.dart';
import 'package:patient_app/screens/doctor_screens/consulting_screen/post_answer_screen.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_divider.dart';
import 'package:patient_app/screens/doctor_screens/widget/custom_navigate.dart';
import '../../../core/models/index_consult_by_doctor_model.dart';
import '../widget/custom_button.dart';

class ShowConsultingScreen extends StatelessWidget {

  ShowConsultingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DoctorConsultCubit, DoctorConsultStates>(

        listener: (context, state) {},
        builder: (context, state) {

          DoctorConsultCubit cubit =DoctorConsultCubit.get(context);

          if( state is DoctorConsultGetQuestionErrorState)
            {
               return const Center(child: Text('Error occurred'),);

            }if(state is DoctorConsultGetQuestionSuccessState)
                {
                   return ConditionalBuilder(
                       condition: state is! DoctorConsultGetQuestionLoadingState,
                       builder: (context) => ListView.separated(
                       itemBuilder: (context, index) => consultItemBuilder(context,index ,cubit.indexConsultByDoctorModel),
                       separatorBuilder: (context, index) => myDivider(),
                       itemCount: cubit.indexConsultByDoctorModel.consultaion.length,
                       ),
                       fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                 ));
         }else{
           return const Center(child: CircularProgressIndicator(),);
         }
        },
        );
  }
}

Widget consultItemBuilder(BuildContext context,int index , IndexConsultByDoctorModel model,
    //DoctorModel doctorModel
    ) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.question_mark_outlined,
                        size: 18.0,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                       Text(
                        '${model.consultaion[index].question}',
                        maxLines: model.consultaion[index].question.length,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 5.0, top: 10.0, bottom: 10.0),
                    child: Container(
                      width: 284.w,
                      height: 1.h,
                      color: Colors.black26,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 61.w,
                      ),
                      defButton(
                          width: 170.w,
                          function: () {
                          navigateTo(context, PostAnswerScreen(consultId:model.consultaion[index]!.id ));
                          },
                          text: 'post your answer',
                          radius: 25.0),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
/*Widget consultItemBuilder( TextEditingController ansController, GlobalKey<FormState> key) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.question_mark_outlined,
                      size: 16.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'question ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                const SizedBox(height: 3.0,),
                Row(
                  children: [
                    TextFormField(
                      cursorColor: defaultColor,
                      controller: ansController,
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
                      onFieldSubmitted: (String value)
                      {

                      },
                      onChanged: (String value)
                      {
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'answer mustn\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(width: 5.0,),
defButton(
                      function: (String value)
                      {

                         if(key.currentState!.validate())
                         {
                              print(ansController.text);
                         }
                      },
                      text: 'send',
                      radius: 25.0,
                      width: 50.0,
                    )

                  ],
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 160.0,
                  ),
                  defButton(
                    function: () {},
                    text: 'send',
                    radius: 25.0,
                    width: 50.0,
                  )
                ],
              )
              ],
            ),
          ),
        ),


  ),
);*/
