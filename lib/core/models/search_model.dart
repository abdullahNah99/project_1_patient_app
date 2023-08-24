
class UsersModel {
  UsersModel({
     this.id,
     this.firstName,
     this.lastName,
     this.phoneNum,
     this.email,
     this.emailVerifiedAt,
     this.role,
     this.createdAt,
     this.updatedAt,
     this.patient,
  });
   final int? id;
   final String? firstName;
   final String? lastName;
   final String? phoneNum;
   final String? email;
   final Null emailVerifiedAt;
   final String? role;
   final String? createdAt;
   final String? updatedAt;
   final PatientsModel? patient;

  factory UsersModel.fromJson(Map<String, dynamic> jsonData) {
    return UsersModel(
      id: jsonData['id'],
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      phoneNum: jsonData['phone_num'],
      email: jsonData['email'],
      emailVerifiedAt: jsonData['email_verified_at'],
      role: jsonData['role'],
      createdAt: jsonData['created_at'],
      updatedAt: jsonData['updated_at'],
      patient: PatientsModel.fromJson(jsonData['patient']),
    );
  }
}

class PatientsModel {
  PatientsModel({
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
   final int id;
   final String address;
   final String FCMToken;
   final String gender;
   final String birthDate;
   final int userId;
   final int patientWallet;
   final String createdAt;
   final String updatedAt;

  factory PatientsModel.fromJson(Map<String, dynamic> jsonData) {
    return PatientsModel(
      id: jsonData['id'],
      address: jsonData['address'],
      FCMToken: jsonData['FCMToken'],
      gender: jsonData['gender'],
      birthDate: jsonData['birth_date'],
      userId: jsonData['user_id'],
      patientWallet: jsonData['patient_wallet'],
      createdAt: jsonData['created_at'],
      updatedAt: jsonData['updated_at'],
    );
  }
}