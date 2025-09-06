// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:teacher/features/Student_history/data/models/tasmi3_model.dart';

class HadithHistoryTasmi3 extends Tasmi3HistoryModel {
  String date;
  String day;
  bool attendance;
  String bookName;
  num pageNamber;
  HadithHistoryTasmi3({
    required this.date,
    required this.day,
    required this.attendance,
    required this.bookName,
    required this.pageNamber,
  });

  HadithHistoryTasmi3 copyWith({
    String? date,
    String? day,
    bool? attendance,
    String? bookName,
    num? pageNamber,
  }) {
    return HadithHistoryTasmi3(
      date: date ?? this.date,
      day: day ?? this.day,
      attendance: attendance ?? this.attendance,
      bookName: bookName ?? this.bookName,
      pageNamber: pageNamber ?? this.pageNamber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'day': day,
      'attendance': attendance,
      'bookName': bookName,
      'pageNamber': pageNamber,
    };
  }

  factory HadithHistoryTasmi3.fromMap(Map<String, dynamic> map) {
    return HadithHistoryTasmi3(
      date: map['date'] as String,
      day: map['day'] as String,
      attendance: map['attendance'] as bool,
      bookName: map['bookName'] as String,
      pageNamber: map['pageNamber'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory HadithHistoryTasmi3.fromJson(String source) => HadithHistoryTasmi3.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HadithHistoryTasmi3(date: $date, day: $day, attendance: $attendance, bookName: $bookName, pageNamber: $pageNamber)';
  }

  @override
  bool operator ==(covariant HadithHistoryTasmi3 other) {
    if (identical(this, other)) return true;
  
    return 
      other.date == date &&
      other.day == day &&
      other.attendance == attendance &&
      other.bookName == bookName &&
      other.pageNamber == pageNamber;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      day.hashCode ^
      attendance.hashCode ^
      bookName.hashCode ^
      pageNamber.hashCode;
  }
}
