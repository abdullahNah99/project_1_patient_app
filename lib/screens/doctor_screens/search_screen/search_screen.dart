import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/functions/custome_snack_bar.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widgets/custome_image.dart';
import '../home_doctor_screen/home_doctor_cubit/home_cubit.dart';
import '../widget/custom_divider.dart';

class SearchScreen extends StatelessWidget
{
   SearchScreen({super.key});
   var searchController = TextEditingController();
   var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<DoctorCubit,DoctorStates>(
      builder: (context,state)
      {
        return Padding( padding:const EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  TextFormField(
                    maxLines: 1,
                    autofocus: true,
                    cursorColor: defaultColor,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration:const InputDecoration(
                      suffixIcon: Icon(
                        Icons.search_outlined,
                        size: 18.0,),
                      hintText: 'Search on Patient',
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
                    onFieldSubmitted: (String text)
                    {
                      DoctorCubit.get(context).search( name: text,
                  token: CacheHelper.getData(key: 'Token'),);
                    },
                    onChanged: (value)
                    {

                    }
                    ,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'field mustn\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if(state is SearchLoadingState)
                    const Center(child:CustomeProgressIndicator(),),
                  if(state is SearchSuccessState)
                    if(state.users.isNotEmpty)
                        Expanded(child: listOfPatients(state)),
                ],
              )),);
      },
      listener: (context,state)
      {
        if(state is SearchErrorState)
        {
          CustomeSnackBar.showSnackBar(context, msg: state.error);
        }
      },
    );

  }

}

Widget listOfPatients(SearchSuccessState state) => ListView.separated(
  itemBuilder: (context,index)=> patientItemBuilder(context,state,index ),
  separatorBuilder:(context,index)=> myDivider(),
  itemCount: state.users.length,
);

Widget patientItemBuilder(BuildContext context,SearchSuccessState state ,int index) => Padding(
  padding: const EdgeInsets.only(left: 5.0,right: 5.0,top: 10.0,bottom: 10.0),
  child: MaterialButton(
    onPressed: () {},
    child: Container(
      padding: const EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          CustomeImage(
            height: 55.h,
            width: 55.w,
            image: 'assets/images/undraw_Coffee_Time_e8cw.png',
            borderRadius: BorderRadius.circular(50.0),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            // 'name',
            '${state.users[index].firstName.toString()}',// ${state.patient[index].userModel?.lastName.toString()}',
            style: const TextStyle(
              color: defaultColor,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ),
  ),
);