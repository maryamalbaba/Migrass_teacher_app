// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:teacher/features/Student_history/data/models/tasmi3_model.dart';

class QuranTasimi3History extends Tasmi3HistoryModel {
  String date;
  String day;
  String attendance;
  String fromSurahName;
  num fromAyah;
  String toSurahName;
  num toAyah;
  QuranTasimi3History({
    required this.date,
    required this.day,
    required this.attendance,
    required this.fromSurahName,
    required this.fromAyah,
    required this.toSurahName,
    required this.toAyah,
  });

  QuranTasimi3History copyWith({
    String? date,
    String? day,
    String? attendance,
    String? fromSurahName,
    num? fromAyah,
    String? toSurahName,
    num? toAyah,
  }) {
    return QuranTasimi3History(
      date: date ?? this.date,
      day: day ?? this.day,
      attendance: attendance ?? this.attendance,
      fromSurahName: fromSurahName ?? this.fromSurahName,
      fromAyah: fromAyah ?? this.fromAyah,
      toSurahName: toSurahName ?? this.toSurahName,
      toAyah: toAyah ?? this.toAyah,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'day': day,
      'attendance': attendance,
      'fromSurahName': fromSurahName,
      'fromAyah': fromAyah,
      'toSurahName': toSurahName,
      'toAyah': toAyah,
    };
  }

  factory QuranTasimi3History.fromMap(Map<String, dynamic> map) {
    return QuranTasimi3History(
      date: map['date'] as String,
      day: map['day'] as String,
      attendance: map['attendance'] as String,
      fromSurahName: map['fromSurahName'] as String,
      fromAyah: map['fromAyah'] as num,
      toSurahName: map['toSurahName'] as String,
      toAyah: map['toAyah'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuranTasimi3History.fromJson(String source) => QuranTasimi3History.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuranTasimi3History(date: $date, day: $day, attendance: $attendance, fromSurahName: $fromSurahName, fromAyah: $fromAyah, toSurahName: $toSurahName, toAyah: $toAyah)';
  }

  @override
  bool operator ==(covariant QuranTasimi3History other) {
    if (identical(this, other)) return true;
  
    return 
      other.date == date &&
      other.day == day &&
      other.attendance == attendance &&
      other.fromSurahName == fromSurahName &&
      other.fromAyah == fromAyah &&
      other.toSurahName == toSurahName &&
      other.toAyah == toAyah;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      day.hashCode ^
      attendance.hashCode ^
      fromSurahName.hashCode ^
      fromAyah.hashCode ^
      toSurahName.hashCode ^
      toAyah.hashCode;
  }
}
