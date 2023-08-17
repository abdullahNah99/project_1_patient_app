import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/patient_model.dart';
import '../cubits/home_cubit/home_patient_cuibt.dart';
import '../cubits/home_cubit/home_patient_states.dart';
import 'custom_doctor_item.dart';

class DoctorsSliverGrid extends StatelessWidget {
  final GetDoctorsAndDepartmentsSuccess state;
  final HomePatientCubit homeCubit;
  final PatientModel patientModel;
  const DoctorsSliverGrid({
    super.key,
    required this.state,
    required this.homeCubit,
    required this.patientModel,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 260.h,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 5.w,
        mainAxisSpacing: 5.h,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomDoctorItem(
            patientModel: patientModel,
            fromFavorite: false,
            doctorModel: state.getDepartmentDoctors(
                departmentImg: (homeCubit.departments.isNotEmpty &&
                        homeCubit.departmentIndex != null)
                    ? homeCubit.departments[homeCubit.departmentIndex!].img
                    : null,
                departmentID: homeCubit.departmentID)[index],
          );
        },
        childCount: state
            .getDepartmentDoctors(departmentID: homeCubit.departmentID)
            .length,
      ),
    );
  }
}
