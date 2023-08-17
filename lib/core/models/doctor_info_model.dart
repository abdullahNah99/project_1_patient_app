
class DoctorInfoModel {
  DoctorInfoModel({
    required this.success,
    required this.message,
    required this.doctor,
  });
  late final bool success;
  late final String message;
  late final List<DoctorModel> doctor;

  DoctorInfoModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    doctor = List.from(json['doctor']).map((e)=>DoctorModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['doctor'] = doctor.map((e)=>e.toJson()).toList();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['specialty'] = specialty;
    _data['description'] = description;
    _data['image_path'] = imagePath;
    _data['department_id'] = departmentId;
    _data['consultation_price'] = consultationPrice;
    _data['review'] = review;
    _data['doctor_wallet'] = doctorWallet;
    _data['user_id'] = userId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['user'] = user.toJson();
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
}
