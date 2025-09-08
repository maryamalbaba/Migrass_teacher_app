import 'package:equatable/equatable.dart';

class MarkModel extends Equatable {
  final int id;
  final int examId;
  final int studentId;
  final String studentName;
  final int score;
  final bool hasTakenExam;
  final String notes;
  final String updatedAt;
  final String createdAt;

  const MarkModel({
    this.id = 0,
    this.examId = 0,
    this.studentId = 0,
    this.score = 0,
    this.hasTakenExam = false,
    this.notes = '',
    this.studentName = '',
     this.updatedAt='',
     this.createdAt='',
  });

  factory MarkModel.fromJson(Map<String, dynamic> json) {
    return MarkModel(
      studentId: json['IdStudent'] as int,
      score: json['result_exam'] as int,
      hasTakenExam: json['has_taken_exam'] as bool,
      notes: json['notes'] as String,
      studentName: (json['studentFirstName'] as String)+" " + (json['studentLastName'] as String),

    );
  }


  MarkModel copyWith({
    int? id,
    int? examId,
    int? studentId,
    int? score,
    bool? hasTakenExam,
    String? notes,
    String? updatedAt,
    String? createdAt,
  }) {
    return MarkModel(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      studentId: studentId ?? this.studentId,
      score: score ?? this.score,
      hasTakenExam: hasTakenExam ?? this.hasTakenExam,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );}


Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'score': score,
      'has_taken_exam': hasTakenExam,
      'notes': 'ثابر نحو الامام',

    };
  }

  @override
  List<Object?> get props => [
    id,
    examId,
    studentId,
    score,
    hasTakenExam,
    notes,
    updatedAt,
    createdAt,
  ];
}