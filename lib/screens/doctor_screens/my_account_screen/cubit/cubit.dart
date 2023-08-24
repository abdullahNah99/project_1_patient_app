import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:patient_app/screens/doctor_screens/my_account_screen/cubit/states.dart';
import '../../../../core/api/services/get_doctor_information.dart';
import '../../../../core/api/services/local/cache_helper.dart';
import '../../../../core/models/doctor_model.dart';


class MyAccountCubit extends Cubit<MyAccountStates>
{
  MyAccountCubit() : super(MyAccountInitialState());
  static MyAccountCubit get(context) =>BlocProvider.of(context);

  DoctorModel? doctorModel;

  Future<void> fetchMyInformation() async {
    emit(MyAccountLoadingState());
    String token = await CacheHelper.getData(key: 'Token');
    int userID = int.parse(JwtDecoder.decode(token)['sub']);
    (await GetDoctorInformationService.getUserInfo(userID: userID)).fold(
          (failure) {
        emit(MyAccountErrorState(error: failure.errorMessege));
      },
       (doctorModel) async {
        this.doctorModel = doctorModel;
        emit(MyAccountSussesState(model: doctorModel));
      },
    );

  }

}