


import 'package:equatable/equatable.dart';

import 'package:teacher/features/lessons/data/model/student_model.dart';

class LessonModel extends Equatable {
  final int id;
  final String name;
  final int typeCircle;
  final String description;
  final List<StudentModel> students;

  const LessonModel({
    this.id = 0,
    this.name = '',
    this.typeCircle = 0,
    this.description = '',
    this.students = const [],
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      typeCircle: json['typeCircle'] as int,
      description: json['description'] as String,
      students: (json['students'] as List<dynamic>)
          .map((student) => StudentModel.fromJson(student as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'typeCircle': typeCircle,
      'description': description,
      'students': students.map((student) => student.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    typeCircle,
    description,
    // students,
  ];
}