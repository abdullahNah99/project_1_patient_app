class IndexAppointmentDoctorModel {
  IndexAppointmentDoctorModel({
    required this.success,
    required this.message,
    required this.appointment,
  });
  late final bool success;
  late final String message;
  late final List<AppointmentModel> appointment;

  IndexAppointmentDoctorModel.fromJson(Map<String, dynamic> json){
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
    required this.date,
    required this.time,
    required this.patientId,
    required this.patient,
  });
  late final String date;
  late final String time;
  late final int patientId;
  late final PatientModel patient;

  AppointmentModel.fromJson(Map<String, dynamic> json){
    date = json['date'];
    time = json['time'];
    patientId = json['patient_id'];
    patient = PatientModel.fromJson(json['patient']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['patient_id'] = patientId;
    data['patient'] = patient.toJson();
    return data;
  }
}

class PatientModel {
  PatientModel({
    required this.id,
    required this.address,
    required this.FCMToken,
    required this.gender,
    required this.birthDate,
    required this.userId,
    required this.patientWallet,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  late final int id;
  late final String address;
  late final String FCMToken;
  late final String gender;
  late final String birthDate;
  late final int userId;
  late final int patientWallet;
  late final String createdAt;
  late final String updatedAt;
  late final UserModel user;

  PatientModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    address = json['address'];
    FCMToken = json['FCMToken'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    userId = json['user_id'];
    patientWallet = json['patient_wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['FCMToken'] = FCMToken;
    data['gender'] = gender;
    data['birth_date'] = birthDate;
    data['user_id'] = userId;
    data['patient_wallet'] = patientWallet;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user.toJson();
    return data;
  }
}

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNum,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String phoneNum;
  late final String email;
  late final Null emailVerifiedAt;
  late final String role;
  late final String createdAt;
  late final String updatedAt;

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNum = json['phone_num'];
    email = json['email'];
    emailVerifiedAt = null;
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_num'] = phoneNum;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}