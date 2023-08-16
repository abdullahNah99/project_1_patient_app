class DateWaitingAppointmentModel {
  DateWaitingAppointmentModel({
    required this.success,
    required this.message,
    required this.appointment,
  });
  late final bool success;
  late final String message;
  late final List<AppointmentModel> appointment;

  DateWaitingAppointmentModel.fromJson(Map<String, dynamic> json){
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
  });
  late final String date;

  AppointmentModel.fromJson(Map<String, dynamic> json){
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    return data;
  }
}