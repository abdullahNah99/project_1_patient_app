import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/styles/app_colors.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';
import '../../../../core/models/secretaria/secretaria_secretaria/view_secretary_model.dart';
import '../../../../core/widgets/custome_arrow_back_button.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../../../main.dart';
import '../../api_cubit/api_cubit.dart';
import '../../patient_profile/widgets/default_text_info.dart';


class SecretaryProfileItem extends StatelessWidget {

  final ViewSecretaryModel? model;
  final formKey = GlobalKey<FormState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  var amount = TextEditingController();

  SecretaryProfileItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
      listener: (context, state) {

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
                right: screenSize.width * .85,
                top: 22.h,
                child: const CustomArrowBackIconButton(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                    top: 130.h,
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
                        /*DefaultTextInfo(
                          caption: 'Address',
                          text: model!.secretary.address,
                          icon: Icons.location_on,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),*/
                        DefaultTextInfo(
                          caption: 'Email',
                          text: model!.secretary.user.email,
                          icon: Icons.mail,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        DefaultTextInfo(
                          caption: 'Phone number',
                          text: model!.secretary.user.phoneNum,
                          icon: Icons.call,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        DefaultTextInfo(
                          caption: 'Department name',
                          text: model!.department.name,
                          icon: Icons.business_sharp,
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
                      '${model!.secretary.user.firstName} ${model!.secretary.user.lastName}',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
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