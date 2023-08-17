import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/screens/doctor_screens/my_account_screen/cubit/cubit.dart';
import 'package:patient_app/screens/doctor_screens/my_account_screen/cubit/states.dart';
import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/widgets/custome_image.dart';
import '../../../core/widgets/custome_progress_indicator.dart';
import '../widget/custom_boxInfo.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> MyAccountCubit()..fetchMyInformation(),
        child: Scaffold(
           appBar: AppBar(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
             bottom: Radius.circular(20.r),
          ),
        ),
              title: Text(
               'My Account',
             style: TextStyle(fontSize: 20.w),
        ),
      ),
           body:MyAccountViewBody(),
    ),);
  }
}
class MyAccountViewBody extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MyAccountCubit,MyAccountStates>(
      listener: (context, state)
      {
        if (state is MyAccountErrorState) {
          CustomeSnackBar.showErrorSnackBar(
            context,
            msg: state.error,
          );
        }
      },
      builder: (context, state)
      {
        if(state is MyAccountSussesState)
        {
            return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       Row(
                         children: [
                         CircleAvatar(
                           child: CustomeNetworkImage(
                             imageUrl: MyAccountCubit.get(context).doctorModel?.imagePath,
                             height: 100.0,
                             width: 100.0,
                             borderRadius:BorderRadius.circular(50.0),
                             fit: BoxFit.contain,),
                           backgroundColor: Colors.black,
                           radius:  51.0,

                         ),
                         const SizedBox(width: 10.0,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: [
                                 const Icon(
                                   Icons.monitor_heart,
                                   size: 16.0,
                                 ),
                                 SizedBox(
                                   width: 5.w,
                                 ),
                                 Text(
                                   'specialty : ${MyAccountCubit.get(context).doctorModel?.specialty}',
                                   style: const TextStyle(fontSize: 15.0),//consultationPrice
                                 ),
                               ],
                             ),
                             const SizedBox(
                               height: 10.0,
                             ),
                             Row(
                               children: [
                                 const Icon(
                                   Icons.attach_money_outlined,
                                   size: 16.0,
                                 ),
                                 SizedBox(
                                   width: 5.w,
                                 ),

                                 Text(
                                   'consultationPrice : ${MyAccountCubit.get(context).doctorModel?.consultationPrice}' ,
                                   style: const TextStyle(fontSize: 15.0),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ],),
                        myInfoBox(text: MyAccountCubit.get(context).doctorModel?.user.firstName ?? 'first name',iconData: Icons.title),
                        myInfoBox(text: MyAccountCubit.get(context).doctorModel?.user.lastName ??'last name',iconData: Icons.title),
                        myInfoBox(text: MyAccountCubit.get(context).doctorModel?.user.phoneNum ??'phone number',iconData: Icons.phone_android_outlined),
                        myInfoBox(text: MyAccountCubit.get(context).doctorModel?.user.email ??'email',iconData: Icons.email_outlined),
                        myInfoBox(text: MyAccountCubit.get(context).doctorModel?.description ??'description',iconData: Icons.description_outlined),
                      ]),
                ),
              );
        }else
        {
          return const CustomeProgressIndicator();
        }

      },
    );
  }

}

