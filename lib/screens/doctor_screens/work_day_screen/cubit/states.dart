import '../../../../core/models/work_day_model.dart';

abstract class WorkTimesStates {}
 class WorkTimesInitialState extends WorkTimesStates {}
 class WorkTimesLoadingState extends WorkTimesStates {}


class ViewWorkTimesSussesState extends WorkTimesStates
{
  final List<WorkDayModel> times;
  ViewWorkTimesSussesState({required this.times});
}

class ViewWorkTimesErrorState extends WorkTimesStates
{
  final String error;
  ViewWorkTimesErrorState({required this.error});
}