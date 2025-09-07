// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/tasmi_send.dart';

class TalqeenTasmi3Send extends TasmiSend {
  num session_id;
  num student_id;
  num from_sura_id;
  num from_verse;
  num to_sura_id;
  num to_verse;
  bool attendance;
  TalqeenTasmi3Send({
    required this.session_id,
    required this.student_id,
    required this.from_sura_id,
    required this.from_verse,
    required this.to_sura_id,
    required this.to_verse,
    required this.attendance,
  });

  TalqeenTasmi3Send copyWith({
    num? session_id,
    num? student_id,
    num? from_sura_id,
    num? from_verse,
    num? to_sura_id,
    num? to_verse,
    bool? attendance,
  }) {
    return TalqeenTasmi3Send(
      session_id: session_id ?? this.session_id,
      student_id: student_id ?? this.student_id,
      from_sura_id: from_sura_id ?? this.from_sura_id,
      from_verse: from_verse ?? this.from_verse,
      to_sura_id: to_sura_id ?? this.to_sura_id,
      to_verse: to_verse ?? this.to_verse,
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
      'attendance': attendance,
    };
  }

  factory TalqeenTasmi3Send.fromMap(Map<String, dynamic> map) {
    return TalqeenTasmi3Send(
      session_id: map['session_id'] as num,
      student_id: map['student_id'] as num,
      from_sura_id: map['from_sura_id'] as num,
      from_verse: map['from_verse'] as num,
      to_sura_id: map['to_sura_id'] as num,
      to_verse: map['to_verse'] as num,
      attendance: map['attendance'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TalqeenTasmi3Send.fromJson(String source) => TalqeenTasmi3Send.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TalqeenTasmi3Send(session_id: $session_id, student_id: $student_id, from_sura_id: $from_sura_id, from_verse: $from_verse, to_sura_id: $to_sura_id, to_verse: $to_verse, attendance: $attendance)';
  }

  @override
  bool operator ==(covariant TalqeenTasmi3Send other) {
    if (identical(this, other)) return true;
  
    return 
      other.session_id == session_id &&
      other.student_id == student_id &&
      other.from_sura_id == from_sura_id &&
      other.from_verse == from_verse &&
      other.to_sura_id == to_sura_id &&
      other.to_verse == to_verse &&
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
      attendance.hashCode;
  }
}
