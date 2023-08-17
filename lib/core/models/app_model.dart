/*
class Appointment2Model {
  Appointment2Model({
    required this.success,
    required this.message,
    required this.Appointment,
  });
  late final bool success;
  late final String message;
  late final List<AppointmentDataModel> Appointment;

  Appointment2Model.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    Appointment = List.from(json['Appointment']).map((e)=>AppointmentDataModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['Appointment'] = Appointment.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class AppointmentDataModel {
  AppointmentDataModel({
    required this.date,
    required this.time,
    required this.patientId,
    required this.patient,
  });
  late final String date;
  late final String time;
  late final int patientId;
  late final PatientDataModel patient;

  AppointmentDataModel.fromJson(Map<String, dynamic> json){
    date = json['date'];
    time = json['time'];
    patientId = json['patient_id'];
    patient = PatientDataModel.fromJson(json['patient']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['time'] = time;
    _data['patient_id'] = patientId;
    _data['patient'] = patient.toJson();
    return _data;
  }
}

class PatientDataModel {
  PatientDataModel({
    required this.id,
    required this.address,
    required this.FCMToken,
    required this.gender,
    required this.birthDate,
    required this.userId,
    required this.patientWallet,
    required this.createdAt,
    required this.updatedAt,
    //required this.user,
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
  //late final User user;

  PatientDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    address = json['address'];
    FCMToken = json['FCMToken'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    userId = json['user_id'];
    patientWallet = json['patient_wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    //user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['address'] = address;
    _data['FCMToken'] = FCMToken;
    _data['gender'] = gender;
    _data['birth_date'] = birthDate;
    _data['user_id'] = userId;
    _data['patient_wallet'] = patientWallet;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
  //  _data['user'] = user.toJson();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['phone_num'] = phoneNum;
    _data['email'] = email;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['role'] = role;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}*/

import 'package:patient_app/core/models/patient_model.dart';

class AppModel<T> {
  final int id;
  final String date;
  final String time;
  final String status;
  final String description;
  final T patientId;
  final int doctorId;
  final PatientModel patientModel;

  AppModel({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.description,
    required this.patientId,
    required this.doctorId,
    required this.patientModel
  });

  factory AppModel.fromJson(Map<String, dynamic> jsonData) {
    return AppModel(
      id:jsonData['id'] ,
      date: jsonData['date'],
      time: jsonData['time'],
      status: jsonData['status'],
      description: jsonData['description'],
      patientId: jsonData['patient_id'],
      doctorId: jsonData['doctor_id'] ,
      patientModel: PatientModel.fromJson(jsonData['patient']),
    );
  }
}

