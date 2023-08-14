class DeleteAppointmentModel {
  DeleteAppointmentModel({
    required this.success,
    required this.message,
  });
  late final bool success;
  late final String message;

  DeleteAppointmentModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}