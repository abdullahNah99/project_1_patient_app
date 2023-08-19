import 'package:patient_app/core/models/doctor_model.dart';
import 'package:patient_app/core/models/patient_model.dart';

class ConsultationModel {
  final String question;
  final String questionDate;
  final int doctorID;
  final int patientID;
  final int id;
  final DoctorModel doctorModel;
  final String? answer;
  final String? answerDate;

  ConsultationModel({
    required this.question,
    required this.questionDate,
    required this.doctorID,
    required this.patientID,
    required this.id,
    required this.doctorModel,
    this.answer,
    this.answerDate,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> jsonData) {
    return ConsultationModel(
      question: jsonData['question'],
      questionDate: jsonData['question_date'],
      doctorID: jsonData['doctor_id'],
      patientID: jsonData['patient_id'],
      doctorModel: DoctorModel.fromJson(jsonData['doctor']),
      id: jsonData['id'],
      answer: jsonData['answer'] ?? '',
      answerDate: jsonData['answer_date'] ?? '',
    );
  }
}






class ConsultationModelForDoctor {
  final String question;
  final String questionDate;
  final int doctorID;
  final int patientID;
  final int id;
  final PatientModel patientModel;
  final String? answer;
  final String? answerDate;

  ConsultationModelForDoctor({
    required this.question,
    required this.questionDate,
    required this.doctorID,
    required this.patientID,
    required this.id,
    required this.patientModel,
    this.answer,
    this.answerDate,
  });

  factory ConsultationModelForDoctor.fromJson(Map<String, dynamic> jsonData) {
    return ConsultationModelForDoctor(
      question: jsonData['question'],
      questionDate: jsonData['question_date'],
      doctorID: jsonData['doctor_id'],
      patientID: jsonData['patient_id'],
      patientModel: PatientModel.fromJson(jsonData['patient']),
      id: jsonData['id'],
      answer: jsonData['answer'] ?? '',
      answerDate: jsonData['answer_date'] ?? '',
    );
  }
}
