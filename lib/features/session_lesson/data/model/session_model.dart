import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class SessionModel extends Equatable {
  final int id;
  final int circleId;
  final String date; // Changed to String
  final String title;
  final String description;
  final String createdAt; // Changed to String
  final String updatedAt; // Changed to String

  const SessionModel({
    this.id = 0,
    this.circleId = 0,
    this.date = '',
    this.title = '',
    this.description = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    // Define date format for YYYY-MM-DD
    final dateFormat = DateFormat('yyyy-MM-dd');

    return SessionModel(
      id: json['id'] as int? ?? 0,
      circleId: json['circle_id'] as int? ?? 0,
      date: json['date'] != null
          ? dateFormat.format(DateTime.parse(json['date'] as String))
          : '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? dateFormat.format(DateTime.parse(json['created_at'] as String))
          : '',
      updatedAt: json['updated_at'] != null
          ? dateFormat.format(DateTime.parse(json['updated_at'] as String))
          : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'circle_id': circleId,
      'date': date,
      'title': title,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
    id,
    circleId,
    date,
    title,
    description,
    createdAt,
    updatedAt,
  ];
}


class SessionRequestModel extends Equatable {
  final String title;
  final String date;
  final String description;

  const SessionRequestModel({
    this.title = '',
    this.date = '',
    this.description = '',
  });

  factory SessionRequestModel.fromJson(Map<String, dynamic> json) {
    return SessionRequestModel(
      title: json['title'] as String? ?? '',
      date: json['date'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [
    title,
    date,
    description,
  ];
}