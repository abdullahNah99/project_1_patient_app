class IndexAppointmentModel {
  IndexAppointmentModel({
    required this.success,
    required this.message,
    required this.appointment,
  });
  late final bool success;
  late final String message;
  late final List<AppointmentModel> appointment;

  IndexAppointmentModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    appointment = List.from(json['Appointment']).map((e)=>AppointmentModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['Appointment'] = appointment.map((e)=>e.toJson()).toList();
    return data;
  }
}

class AppointmentModel {
  AppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.description,
    required this.patientId,
    required this.doctorId,
    required this.departmentId,
    required this.cancelReason,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String date;
  late final String time;
  late final String status;
  late final String description;
  late final int patientId;
  late final int doctorId;
  late final int departmentId;
  late final String cancelReason;
  late final String createdAt;
  late final String updatedAt;

  AppointmentModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    description = json['description'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    departmentId = json['department_id'];
    cancelReason = json['cancel_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['description'] = description;
    data['patient_id'] = patientId;
    data['doctor_id'] = doctorId;
    data['department_id'] = departmentId;
    data['cancel_reason'] = cancelReason;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}