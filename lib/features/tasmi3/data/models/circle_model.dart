// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:teacher/features/tasmi3/data/models/student_model.dart';

class CircleModel {
  String name;
  List<StudentModel> students;
  CircleModel({
    required this.name,
    required this.students,
  });

  CircleModel copyWith({
    String? name,
    List<StudentModel>? students,
  }) {
    return CircleModel(
      name: name ?? this.name,
      students: students ?? this.students,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'students': students.map((x) => x.toMap()).toList(),
    };
  }

factory CircleModel.fromMap(Map<String, dynamic> map) {
  return CircleModel(
    name: map['name']?.toString() ?? '',
    students: (map['students'] is List)
        ? List<StudentModel>.from(
            (map['students'] as List).map(
              (e) => e is Map<String, dynamic> ? StudentModel.fromMap(e) : StudentModel(first_name: '', last_name: ''),
            ),
          )
        : [],
  );
}


  String toJson() => json.encode(toMap());

  factory CircleModel.fromJson(String source) => CircleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CircleModel(name: $name, students: $students)';

  @override
  bool operator ==(covariant CircleModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      listEquals(other.students, students);
  }

  @override
  int get hashCode => name.hashCode ^ students.hashCode;
}
