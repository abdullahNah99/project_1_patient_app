import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:patient_app/core/models/patient_model.dart';
import '../../errors/failures.dart';
import '../../models/doctor_info_model.dart';
import '../http_api_services.dart';

abstract class GetDoctorInfoService {
  static const String _adminToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZmY0ZWMxZThhZDljNmY4ZmVmYzNlYzgxOWIxZjQ2OTM3NWI4OWQ1ZTc1NmJlYjBlZTNlNmM1Zjg3OTQ5NjhhMjc5MDE0YzQ5MTY5ZjkxYjEiLCJpYXQiOjE2OTE0NzM1MzYuNTc0ODI1LCJuYmYiOjE2OTE0NzM1MzYuNTc0ODMsImV4cCI6MTcyMzA5NTkzNi41NTc4OTUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.xoJ-WhdrIJVGrWYmU7PlHbuC6sGs59LWw3vuwD-ywlS-xX2U2pDV27zNy1bLinaAk771W9wFyKFG4fACmmdsXfr3oshVrdWI7Rs4tfpHmtR5lAQ6aohIQJg9qeeWEUOWzWcI9R9L2Kv_q6UWV_eGyne2_zJCy728rMP2k3Vw_UYdv4SgfJhErmfia9MNJzb3d48SZRYyqGFIB61uXLG33trOCYOvO_oKnyxpGls5mNZ0Ep6I-3yYPFwlM9YDcX4BTVWVvx1c8Tje6cbLBdXy_MaQAsf8SHdra7XEK6Zb8TJhLjnwuEwbQL8RBNtxi_PPIG0hYDaczUKZXaO3iDmvwQKTnqMZsYI9H1SddXuJOJgnc9Ppzl-4NXLxJTWjwYjVuQxne3t0DAqNaZoC_0E5ut8K5HZ0pd3A4UyOZL2E0gojkMQXaoY9YKfueCQlhTHZ3aYT7Gawgc_2_X9ujGNQNsDa-1rvQSJLE40-1xwITVTS5pq-Tm945rHZibhWxfq0Wt0sZ4kpmS9RULTt3hKpbgDfgQSqroXBMFkWINSQ1_FF4aLTjc1_mxADp1qOauYDPY34zdGB0UhCzatPdMNVWu7nG_paMcmQIKVMdg2JkKyH4jMVV40rAB9yqLjeyVKe9z3u0v58XxLJGg9uvk7bdB_XoFTz4JDp7gHBadJqLgA';
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
