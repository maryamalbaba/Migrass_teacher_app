// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/tasmi_send.dart';

class QuranTasmi3Send extends TasmiSend {
  num session_id;
  num student_id;
  num from_sura_id;
  num from_verse;
  num to_sura_id;
  num to_verse;
  bool is_counted;
  bool is_exam;
  bool attendance;
  QuranTasmi3Send({
    required this.session_id,
    required this.student_id,
    required this.from_sura_id,
    required this.from_verse,
    required this.to_sura_id,
    required this.to_verse,
    required this.is_counted,
    required this.is_exam,
    required this.attendance,
  });

  QuranTasmi3Send copyWith({
    num? session_id,
    num? student_id,
    num? from_sura_id,
    num? from_verse,
    num? to_sura_id,
    num? to_verse,
    bool? is_counted,
    bool? is_exam,
    bool? attendance,
  }) {
    return QuranTasmi3Send(
      session_id: session_id ?? this.session_id,
      student_id: student_id ?? this.student_id,
      from_sura_id: from_sura_id ?? this.from_sura_id,
      from_verse: from_verse ?? this.from_verse,
      to_sura_id: to_sura_id ?? this.to_sura_id,
      to_verse: to_verse ?? this.to_verse,
      is_counted: is_counted ?? this.is_counted,
      is_exam: is_exam ?? this.is_exam,
      attendance: attendance ?? this.attendance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'session_id': session_id,
      'student_id': student_id,
      'from_sura_id': from_sura_id,
      'from_verse': from_verse,
      'to_sura_id': to_sura_id,
      'to_verse': to_verse,
      'is_counted': is_counted,
      'is_exam': is_exam,
      'attendance': attendance,
    };
  }

  factory QuranTasmi3Send.fromMap(Map<String, dynamic> map) {
    return QuranTasmi3Send(
      session_id: map['session_id'] as num,
      student_id: map['student_id'] as num,
      from_sura_id: map['from_sura_id'] as num,
      from_verse: map['from_verse'] as num,
      to_sura_id: map['to_sura_id'] as num,
      to_verse: map['to_verse'] as num,
      is_counted: map['is_counted'] as bool,
      is_exam: map['is_exam'] as bool,
      attendance: map['attendance'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuranTasmi3Send.fromJson(String source) => QuranTasmi3Send.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuranTasmi3Send(session_id: $session_id, student_id: $student_id, from_sura_id: $from_sura_id, from_verse: $from_verse, to_sura_id: $to_sura_id, to_verse: $to_verse, is_counted: $is_counted, is_exam: $is_exam, attendance: $attendance)';
  }

  @override
  bool operator ==(covariant QuranTasmi3Send other) {
    if (identical(this, other)) return true;
  
    return 
      other.session_id == session_id &&
      other.student_id == student_id &&
      other.from_sura_id == from_sura_id &&
      other.from_verse == from_verse &&
      other.to_sura_id == to_sura_id &&
      other.to_verse == to_verse &&
      other.is_counted == is_counted &&
      other.is_exam == is_exam &&
      other.attendance == attendance;
  }

  @override
  int get hashCode {
    return session_id.hashCode ^
      student_id.hashCode ^
      from_sura_id.hashCode ^
      from_verse.hashCode ^
      to_sura_id.hashCode ^
      to_verse.hashCode ^
      is_counted.hashCode ^
      is_exam.hashCode ^
      attendance.hashCode;
  }
}
