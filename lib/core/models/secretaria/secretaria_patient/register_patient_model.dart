class RegisterPatientModel
{
  late String token;
  late String role;

  RegisterPatientModel.fromJson(Map<String,dynamic> jsonData){
    token = jsonData['token'];
    role = jsonData['role'];
  }
}