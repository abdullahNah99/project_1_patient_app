import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/doctor_info_model.dart';
import '../http_api_services.dart';

abstract class GetDoctorInfoService {
  static const String _adminToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjY5MzI3ZTEwNDI3NGRmMzE1YzE2NmVlMjAzNDIxNjRkZWIzNzcwNzdlZjM0MDY0MmYzNjFlZDQ0ZTE0Mzg2MDRiYmE5NzczZTkzYTFiZjYiLCJpYXQiOjE2OTE1ODUzMTYuNzc3NTc5LCJuYmYiOjE2OTE1ODUzMTYuNzc3NTgyLCJleHAiOjE3MjMyMDc3MTYuNzY3ODg5LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.mqMrUix6vASVF8PF-ISzjGjFIY8ce-raRhCncnrslJkoClOF62tfUnPuMqLwqGdYv6_ex5vDFavPoDqcYL4Ks9JK72n3GQ2xLMkQF1vnhM7ut6j6kgDQ7kWHGldhT1cyFxe9rNiw6Ixl3-7l88r_BC-Ee2y3nsG1AUmCwC2v8MTvJNNsCq_PcD5rAHI7zgIJQWuCWY5Q_e6_a-qST2DtWwPE9_EIdFXJuxvsbg0aQnTVQKfrya3TYuTfH6R5Bwit4JXR7PUzJeVHHMK5K5F0uLdfOcxrM_Jeeygg5DBdJlvBSP6GtvFqx1zTJBOOXMXXEuNvyYadcw6yehwJ8QcG3hr_tsK48HxeCH8W-dpUusLsZ8guu6-cqzQzOsopMFD7Ves0NUYzAqRWBjAEm0kLH8DdMTdCiG3WlVHl3Z_omglKtkl9sXejERAnveII1ZHv0WTlSVLL_IgO-2hkkeiJKLHK4EjKV5Wh03SNJGBEKswOZ9FkkZUtYJWgO86LSf5V2D_Hp05MhlYgwAHy4HxEuz0y9x5nzfZgvK3YNKOFPKhLcdcjOVBjirFLz61HcB1yg3_7wmyXuW5qzo0B2MRIK5IKByPaJYSklrRPsuC1MgYNhwAqsovu5VGYWeXyWUJfJXEN-LsFnL-uGeuhEV0sO4IvPo7UyN5nmyi9oJCAkNI'
  ;
  static Future<Either<Failure, DoctorInfoModel>> getMyInfo({
    required int userID,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'viewDoctor',
        body: {
          'user_id': '$userID',
        },
        token: _adminToken,
      );

      return right(DoctorInfoModel.fromJson(data['Doctor']));
    } catch (ex) {
      log('Exception: there is an error in getMyInfo');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}

/*abstract class GetDoctorIdService {
  static const String _adminToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjY5MzI3ZTEwNDI3NGRmMzE1YzE2NmVlMjAzNDIxNjRkZWIzNzcwNzdlZjM0MDY0MmYzNjFlZDQ0ZTE0Mzg2MDRiYmE5NzczZTkzYTFiZjYiLCJpYXQiOjE2OTE1ODUzMTYuNzc3NTc5LCJuYmYiOjE2OTE1ODUzMTYuNzc3NTgyLCJleHAiOjE3MjMyMDc3MTYuNzY3ODg5LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.mqMrUix6vASVF8PF-ISzjGjFIY8ce-raRhCncnrslJkoClOF62tfUnPuMqLwqGdYv6_ex5vDFavPoDqcYL4Ks9JK72n3GQ2xLMkQF1vnhM7ut6j6kgDQ7kWHGldhT1cyFxe9rNiw6Ixl3-7l88r_BC-Ee2y3nsG1AUmCwC2v8MTvJNNsCq_PcD5rAHI7zgIJQWuCWY5Q_e6_a-qST2DtWwPE9_EIdFXJuxvsbg0aQnTVQKfrya3TYuTfH6R5Bwit4JXR7PUzJeVHHMK5K5F0uLdfOcxrM_Jeeygg5DBdJlvBSP6GtvFqx1zTJBOOXMXXEuNvyYadcw6yehwJ8QcG3hr_tsK48HxeCH8W-dpUusLsZ8guu6-cqzQzOsopMFD7Ves0NUYzAqRWBjAEm0kLH8DdMTdCiG3WlVHl3Z_omglKtkl9sXejERAnveII1ZHv0WTlSVLL_IgO-2hkkeiJKLHK4EjKV5Wh03SNJGBEKswOZ9FkkZUtYJWgO86LSf5V2D_Hp05MhlYgwAHy4HxEuz0y9x5nzfZgvK3YNKOFPKhLcdcjOVBjirFLz61HcB1yg3_7wmyXuW5qzo0B2MRIK5IKByPaJYSklrRPsuC1MgYNhwAqsovu5VGYWeXyWUJfJXEN-LsFnL-uGeuhEV0sO4IvPo7UyN5nmyi9oJCAkNI'
  ;
  static Future<Either<Failure, DoctorInfoModel>> getId({
    required int id,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'viewDoctor',
        body: {
          'id': '$id',
        },
        token: _adminToken,
      );

      return right(DoctorInfoModel.fromJson(data['Doctor']));
    } catch (ex) {
      log('Exception: there is an error in getMyInfo');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}*/
