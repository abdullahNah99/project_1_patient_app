import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/utils/app_assets.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_states.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../api_cubit/api_cubit.dart';
import '../../doctor_appointment_list/appointment_list_doctor.dart';

class DoctorListViewItem extends StatelessWidget {

  final String? profImage;
  final int? departmentId;
  //final IndexByDepartmentModel model;


  const DoctorListViewItem(
      BuildContext? context, {
        super.key,
        this.profImage,
        this.departmentId,
        //required this.model,
      });


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SecretariaLyoutCubit()..indexDoctorByDepartment(department_id: departmentId!),
      child: BlocConsumer<SecretariaLyoutCubit,SecretariaLyoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
          if(state is DoctorListByDepartmentErrorState)
          {
            return Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 15.0,
                end: 15.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Center(
                child: Text(
                  'There is some thing error',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            );
          }else if(state is DoctorListByDepartmentLoadingState)
          {
            return const Center(child: CircularProgressIndicator());
          }else
          {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 3.w,
                  end: 3.w,
                  top: 3.h,
                  bottom: 3.h,
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentsListDoctor(doctorId: cubit.indexDoctorByDepartmentModel.doctor[index].id,)),
                    );
                  },
                  child: Material(
                    shadowColor: Colors.grey.shade50,
                    elevation: 5.0,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                    color: Colors.white,
                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10.r)),
                        border: const Border.fromBorderSide(BorderSide.none),
                      ),
                      padding: EdgeInsetsDirectional.only(
                        start: 6.h,
                        end: 6.h,
                        top: 5.h,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .25,
                              width: 145.w,
                              //margin: EdgeInsets.only(top: screenSize.height * .16),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10.h),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${Constants.baseURL}upload/${cubit.indexDoctorByDepartmentModel.doctor[index].imagePath}',
                                    ),
                                  )
                              ),
                            ),
                            /*CustomeImage(
                              image: AppAssets.defaultImagePurple,
                              width: 145.w,
                              //height: 150.h,
                              borderRadius: BorderRadius.circular(15),
                            ),*/
                            SizedBox(
                              height: 6.h,
                            ),
                            Container(
                              height: .6.h,
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                            Expanded(
                              child: Text(
                                '${cubit.indexDoctorByDepartmentModel.doctor[index].user.firstName} ${cubit.indexDoctorByDepartmentModel.doctor[index].user.lastName}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.w,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Expanded(
                              child: Text(
                                cubit.indexDoctorByDepartmentModel.doctor[index].user.phoneNum,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w400
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 5.h,
                  childAspectRatio: 3/2,
                  mainAxisExtent: 260.h
              ),
              itemCount: cubit.indexDoctorByDepartmentModel.doctor.length,
            );
          }
        },
      ),
    );
  }
}