class IndexDoctorByDepartmentModel {
  IndexDoctorByDepartmentModel({
    required this.success,
    required this.message,
    required this.doctor,
  });
  late final bool success;
  late final String message;
  late final List<DoctorModel> doctor;

  IndexDoctorByDepartmentModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    doctor = List.from(json['Doctor']).map((e)=>DoctorModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['Doctor'] = doctor.map((e)=>e.toJson()).toList();
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
  late final UserModel user;

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
    user = UserModel.fromJson(json['user']);
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