import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/models/patient_model.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/patient_screens/favourite_screen/cubit/favourite_states.dart';
import '../home_patient_screen/widgets/custom_doctor_item.dart';
import 'cubit/favourite_cubit.dart';

class FavouriteView extends StatelessWidget {
  static const route = 'FavouriteView';
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    PatientModel patientModel =
        ModalRoute.of(context)!.settings.arguments as PatientModel;
    return BlocProvider(
      create: (context) => FavouriteCubit()..getFavourite(),
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.r),
            ),
          ),
          title: Text(
            'Favourite',
            style: TextStyle(fontSize: 20.w),
          ),
        ),
        body: FavouriteViewBody(patientModel: patientModel),
      ),
    );
  }
}

class FavouriteViewBody extends StatelessWidget {
  final PatientModel patientModel;
  const FavouriteViewBody({super.key, required this.patientModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteStates>(
      builder: (context, state) {
        if (state is FavouriteSuccess) {
          if (state.doctors.isEmpty) {
            return Center(
              child: Text(
                'Favorite is empty',
                style: TextStyle(color: Colors.grey, fontSize: 30.w),
              ),
            );
          } else {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 260.h,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 5.w,
                mainAxisSpacing: 5.h,
              ),
              itemCount: state.doctors.length,
              itemBuilder: (context, index) {
                return CustomDoctorItem(
                  doctorModel: state.doctors[index],
                  fromFavorite: true,
                  patientModel: patientModel,
                );
              },
            );
          }
        } else if (state is FavouriteFailure) {
          return Center(
            child: Text(
              'Favorite is empty',
              style: TextStyle(color: Colors.grey, fontSize: 30.w),
            ),
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
      listener: (context, state) {
        // if (state is FavouriteFailure) {
        //   CustomeSnackBar.showErrorSnackBar(
        //     context,
        //     msg: state.failureMsg,
        //   );
        // }
      },
    );
  }
}
