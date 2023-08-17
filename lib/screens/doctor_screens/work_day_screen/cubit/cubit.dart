import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/screens/doctor_screens/work_day_screen/cubit/states.dart';
import '../../../../core/api/services/get_my_work_times_service.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/models/work_day_model.dart';

class WorkTimesCubit extends Cubit<WorkTimesStates>
{

  WorkTimesCubit() : super(WorkTimesInitialState());
  static WorkTimesCubit get(context) =>BlocProvider.of(context);

  List<WorkDayModel> times = [];

  /*Future<void> getWorkDay({required String token})async
  {
    emit(WorkTimesLoadingState());
    (await GetAllDoctorsTimes.getAllDoctorsTimes(token:Constants.adminToken)
    ).fold((error)
    {
      emit(ViewWorkTimesErrorState(error: error.errorMessege));
    } ,
            (times)
        {
          emit(ViewWorkTimesSussesState(
            times: times,),
          );
          print(times[0].day);

        });


  }*/

  Future<void> getMyWorkTimes({required String token})async
  {
    emit(WorkTimesLoadingState());
    (await GetMyWorkTimes.getMyWorkTimes(token: await CacheHelper.getData(key: 'Token'))
    ).fold((error)
    {
      emit(ViewWorkTimesErrorState(error: error.errorMessege));
    } ,
            (times)
        {
          emit(ViewWorkTimesSussesState(
            times: times,),
          );
          print(times[0].day);

        });


  }


}