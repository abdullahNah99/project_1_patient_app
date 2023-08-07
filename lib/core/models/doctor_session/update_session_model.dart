class UpdateSessionModel {
  UpdateSessionModel({
    required this.success,
    required this.message,
    required this.session,
  });
  late final bool success;
  late final String message;
  late final SessionModel session;

  UpdateSessionModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    session = SessionModel.fromJson(json['session']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['session'] = session.toJson();
    return _data;
  }
}

class SessionModel {
  SessionModel({
    required this.id,
    required this.medicine,
    required this.report,
    required this.imagePath,
    required this.appointmentId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String medicine;
  late final String report;
  late final String imagePath;
  late final int appointmentId;
  late final String createdAt;
  late final String updatedAt;

  SessionModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    medicine = json['medicine'];
    report = json['report'];
    imagePath = json['image_path'];
    appointmentId = json['appointment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['medicine'] = medicine;
    _data['report'] = report;
    _data['image_path'] = imagePath;
    _data['appointment_id'] = appointmentId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}