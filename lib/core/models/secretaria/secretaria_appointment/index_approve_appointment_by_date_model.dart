class IndexApproveAppointmentByDateModel {
  IndexApproveAppointmentByDateModel({
    required this.success,
    required this.message,
    required this.appointment,
  });
  late final bool success;
  late final String message;
  late final List<AppointmentModel> appointment;

  IndexApproveAppointmentByDateModel.fromJson(Map<String, dynamic> json){
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
    required this.doctor,
    required this.patient,
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
  late final DoctorModel doctor;
  late final PatientModel patient;

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
    doctor = DoctorModel.fromJson(json['doctor']);
    patient = PatientModel.fromJson(json['patient']);
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
    data['doctor'] = doctor.toJson();
    data['patient'] = patient.toJson();
    return data;
  }
}

class DoctorModel {
  DoctorModel({
    required this.id,
    required this.specialty,
    required this.description,
    required this.imagePath,
    required this.departmentId,
    required this.consultationPrice,
    required this.review,
    required this.doctorWallet,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  late final int id;
  late final String specialty;
  late final String description;
  late final String imagePath;
  late final int departmentId;
  late final int consultationPrice;
  late final int review;
  late final int doctorWallet;
  late final int userId;
  late final String createdAt;
  late final String updatedAt;
  late final User user;

  DoctorModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    specialty = json['specialty'];
    description = json['description'];
    imagePath = json['image_path'];
    departmentId = json['department_id'];
    consultationPrice = json['consultation_price'];
    review = json['review'];
    doctorWallet = json['doctor_wallet'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['specialty'] = specialty;
    data['description'] = description;
    data['image_path'] = imagePath;
    data['department_id'] = departmentId;
    data['consultation_price'] = consultationPrice;
    data['review'] = review;
    data['doctor_wallet'] = doctorWallet;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user.toJson();
    return data;
  }
}

class User {
  User({
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

  User.fromJson(Map<String, dynamic> json){
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
  late final User user;

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
    user = User.fromJson(json['user']);
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