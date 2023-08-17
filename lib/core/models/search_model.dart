class SearchOnPatientModel {
  SearchOnPatientModel({
    required this.success,
    required this.message,
    required this.users,
  });
  late final bool success;
  late final String message;
  late final List<Users> users;

  SearchOnPatientModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['users'] = users.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Users {
  Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNum,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.patient,
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
  late final Patient patient;

  Users.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNum = json['phone_num'];
    email = json['email'];
    emailVerifiedAt = null;
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    patient = Patient.fromJson(json['patient']);
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
    _data['patient'] = patient.toJson();
    return _data;
  }
}

class Patient {
  Patient({
    required this.id,
    required this.address,
    required this.FCMToken,
    required this.gender,
    required this.birthDate,
    required this.userId,
    required this.patientWallet,
    required this.createdAt,
    required this.updatedAt,
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

  Patient.fromJson(Map<String, dynamic> json){
    id = json['id'];
    address = json['address'];
    FCMToken = json['FCMToken'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    userId = json['user_id'];
    patientWallet = json['patient_wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return _data;
  }
}