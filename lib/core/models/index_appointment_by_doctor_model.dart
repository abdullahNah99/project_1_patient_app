class IndexAppointmentByDoctorModel {
  IndexAppointmentByDoctorModel({
    required this.success,
    required this.message,
    required this.appointment,
  });
  late final bool success;
  late final String message;
  late final List<AppointmentModel> appointment;

  IndexAppointmentByDoctorModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    appointment = List.from(json['Appointment']).map((e)=>AppointmentModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['Appointment'] = appointment.map((e)=>e.toJson()).toList();
    return _data;
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
    required this.department,
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
  late final Department department;

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
    department = Department.fromJson(json['department']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['time'] = time;
    _data['status'] = status;
    _data['description'] = description;
    _data['patient_id'] = patientId;
    _data['doctor_id'] = doctorId;
    _data['department_id'] = departmentId;
    _data['cancel_reason'] = cancelReason;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['department'] = department.toJson();
    return _data;
  }
}

class Department {
  Department({
    required this.id,
    required this.name,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String img;
  late final String createdAt;
  late final String updatedAt;

  Department.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['img'] = img;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}