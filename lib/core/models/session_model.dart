/*
class SessionModel {
  SessionModel({
    required this.success,
    required this.message,
    required this.session,
  });
  late final bool success;
  late final String message;
  late final SessionDataModel session;

  SessionModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    session = SessionDataModel.fromJson(json['session']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['session'] = session.toJson();
    return _data;
  }
}

class SessionDataModel {
  SessionDataModel({
    required this.medicine,
    required this.report,
    required this.appointmentId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
  late final String medicine;
  late final String report;
  late final String appointmentId;
  late final String updatedAt;
  late final String createdAt;
  late final int id;

  SessionDataModel.fromJson(Map<String, dynamic> json){
    medicine = json['medicine'];
    report = json['report'];
    appointmentId = json['appointment_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['medicine'] = medicine;
    _data['report'] = report;
    _data['appointment_id'] = appointmentId;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['id'] = id;
    return _data;
  }
}


*/

class SessionModel{
   final String? medicine;
   final String? report;
   final String? appointmentId;
   final String? updatedAt;
   final String? createdAt;
   final int? id;

   SessionModel({
     required this.medicine,
     required this.report,
     required this.appointmentId,
     required this.updatedAt,
     required this.createdAt,
     required this.id,
});

   factory SessionModel.fromJson(Map<String, dynamic> jsonData) {
     return SessionModel(
       id: jsonData['id'],
       createdAt: jsonData['createdAt'],
       updatedAt: jsonData['updatedAt'],
       appointmentId: jsonData['appointmentId'],
       report: jsonData['report'],
       medicine: jsonData['medicine'],
     );
   }

}