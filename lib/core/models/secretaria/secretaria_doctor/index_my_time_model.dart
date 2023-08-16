class IndexMyTimeModel {
  IndexMyTimeModel({
    required this.success,
    required this.message,
    required this.workDay,
  });
  late final bool success;
  late final String message;
  late final List<WorkDayModel> workDay;

  IndexMyTimeModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    workDay = List.from(json['workDay']).map((e)=>WorkDayModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['workDay'] = workDay.map((e)=>e.toJson()).toList();
    return data;
  }
}

class WorkDayModel {
  WorkDayModel({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.doctorId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String day;
  late final String startTime;
  late final String endTime;
  late final int doctorId;
  late final String createdAt;
  late final String updatedAt;

  WorkDayModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    doctorId = json['doctor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['doctor_id'] = doctorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}