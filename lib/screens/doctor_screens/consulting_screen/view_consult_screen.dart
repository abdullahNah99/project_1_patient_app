import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/patient_screens/show_all_consultation/cuibt/show_all_consultation_states.dart';

import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/models/consultation_model.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_error_widget.dart';
import '../../../core/widgets/custome_image.dart';
import '../../../core/widgets/custome_progress_indicator.dart';
import '../../patient_screens/show_all_consultation/cuibt/show_all_consultation_cubit.dart';
import '../../patient_screens/show_all_consultation/widgets/consultation_item.dart';

class ViewConsultScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ShowAllConsultationCubit()..getAllDoctorConsultations(token: CacheHelper.getData(key: 'Token'),),
    child: Scaffold(
      appBar: AppBar(
        title: const Text('View All Consulting'),
      ),
      body: const ViewConsultScreenBody(),
    ),);
  }

}
class ViewConsultScreenBody extends StatelessWidget {

  final int? doctorID;
  const ViewConsultScreenBody({
    super.key,
    this.doctorID,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowAllConsultationCubit, ShowAllConsultationStates>(
        builder: (context, state) {
          if (state is GetAllPatientConsultationsErrorState) {
            return CustomeErrorWidget(errorMsg: state.failureMsg);
          } else if (state is GetAllPatientConsultationsLoadingState) {
            return const CustomeProgressIndicator();
          } else if (state is GetAllDoctorConsultationsSuccessState) {
            if (doctorID == null) {
              return Body(model: state.allConsulations);
            } else {
              return Body(
                  model: state.allConsulations);
            }
          } else {
            return const Body();
          }
        }, listener: (context, state) {});
  }
}


class Body extends StatelessWidget {
  final List<ConsultationModelForDoctor>? model;
  const Body({this.model});

  @override
  Widget build(BuildContext context) {
    return (model != null && model!.isNotEmpty)
        ? ListView.builder(
      itemCount: model!.length,
      itemBuilder: (context, index) =>
          ConsultationItemForDoctor(consultationModel: model![index]),
    )
        : Center(
      child: Text(
        'No consulting yet',
        style: TextStyle(color: Colors.grey, fontSize: 20.w),
      ),
    );
  }
}



class ConsultationItemForDoctor extends StatelessWidget {
  final ConsultationModelForDoctor consultationModel;
  const ConsultationItemForDoctor({super.key, required this.consultationModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: defaultColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
          // height: 150.h,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 240.w,
                      child: Text(
                        consultationModel.question,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Text(
                        consultationModel.questionDate,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: defaultColor,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // consultationModel.doctorModel.imagePath == 'default'
                    //     ?
                  CustomeImage(
                      width: 50.w,
                      height: 45.h,
                      borderRadius: BorderRadius.circular(50.r),
                      margin: const EdgeInsets.all(10),
                    ),
                    //     : CustomeNetworkImage(
                    //   imageUrl: consultationModel.patientModel.imagePath,
                    //   width: 50.w,
                    //   height: 45.h,
                    //   fit: BoxFit.fill,
                    //   borderRadius: BorderRadius.circular(50.r),
                    //   margin: const EdgeInsets.all(10),
                    // ),
                    SizedBox(
                      width: 210.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 8.h,
                            ),
                            child: Text(
                            'Dr. ${consultationModel.patientModel.userModel!.firstName} ${consultationModel.patientModel.userModel!.lastName}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                          Divider(
                            endIndent: 60.w,
                            height: 10.h,
                          ),
                          Text(
                            consultationModel.answer.toString() == "null"
                                ? 'No Answer Yet '
                                : consultationModel.answer.toString(),
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 40.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          consultationModel.answer.toString() == "null"
                              ? const Icon(
                            Icons.priority_high_rounded,
                            color: Colors.red,
                          )
                              : const Icon(
                            Icons.check_circle_outlined,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (consultationModel.answer.toString() != "null")
                  Divider(
                    color: defaultColor,
                    height: 10.h,
                  ),
                if (consultationModel.answer.toString() != "null")
                  Text(consultationModel.answerDate.toString()),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5.w,
          top: 0,
          child: Icon(
            // model![index].answer.toString() == "null"
            // ?
            Icons.question_mark,
            // : Icons.check_rounded,
            size: 60,
            color: consultationModel.answer.toString() == "null"
                ? Colors.orange
                : Colors.green,
          ),
        ),
      ],
    );
  }
}
