
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
      required this.patientModel});

  factory AppModel.fromJson(Map<String, dynamic> jsonData) {
    return AppModel(
      id: jsonData['id'],
      date: jsonData['date'],
      time: jsonData['time'],
      status: jsonData['status'],
      description: jsonData['description'],
      patientId: jsonData['patient_id'],
      doctorId: jsonData['doctor_id'],
      patientModel: PatientModel.fromJson(jsonData['patient']),
    );
  }
}
