class ChargeWalletModel
{
  late bool success;
  late String message;

  ChargeWalletModel.fromJson(Map<String,dynamic> jsonData){
    success = jsonData['success'];
    message = jsonData['message'];
  }
}