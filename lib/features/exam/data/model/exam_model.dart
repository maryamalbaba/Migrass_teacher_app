import 'package:equatable/equatable.dart';

class ExamModel extends Equatable {
  final int id;
  final int circleId;
  final String title;
  final String description;
  final String date;
  final String createdAt;
  final String updatedAt;

  const ExamModel({
    this.id = 0,
    this.circleId = 0,
    this.title = '',
    this.description = '',
     this.date='',
  this.createdAt='',
    this.updatedAt='',
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] as int,
      circleId: json['circle_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      createdAt:json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'circle_id': circleId,
      'title': title,
      'description': description,
      'date': date,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
    id,
    circleId,
    title,
    description,
    date,
    createdAt,
    updatedAt,
  ];
}