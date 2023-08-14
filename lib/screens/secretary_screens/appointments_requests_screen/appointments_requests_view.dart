import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/widgets/custome_progress_indicator.dart';
import 'package:patient_app/screens/secretary_screens/api_cubit/api_cubit.dart';
import 'package:patient_app/screens/secretary_screens/appointments_requests_screen/widgets/appointment_request_item.dart';
import '../api_cubit/api_states.dart';

class AppointmentsRequestsView extends StatelessWidget {
  static const route = 'AppointmentsRequestsView';

  final String? date;
  final String token;
  const AppointmentsRequestsView({super.key, required this.token, this.date});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SecretariaLyoutCubit()..indexAppointmentByDate(date: date!),
      child: const Scaffold(
        body: AppointmentsRequestsViewBody(),
      ),
    );
  }
}

class AppointmentsRequestsViewBody extends StatelessWidget {
  const AppointmentsRequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecretariaLyoutCubit, SecretariaLyoutStates>(
      builder: (context, state) {
        SecretariaLyoutCubit cubit = SecretariaLyoutCubit.get(context);
        if(state is ApppintmentListByDateErrorState)
        {
          return Padding(
            padding: EdgeInsetsDirectional.only(
              start: 15.0,
              end: 15.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Center(
                  child: Text(
                    'There Are No Appointment',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          );
        }else if (state is ApppintmentListByDateSuccssesState) {
          return ListView.builder(
            /*physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,*/
            itemBuilder: (context, index) => AppointmentRequestItem(model: cubit.indexAppointmentByDateModel, index: index < 0 ? 0 : index),
            itemCount: cubit.indexAppointmentByDateModel.appointment.length/*state.appointments.length*/,
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }
}
