// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/tasmi_send.dart';

class Hadithtasmi3  extends TasmiSend{
  num session_id;
  num student_id;
  num book_id;
  num from_hadith;
  num to_hadith;
  bool is_counted;
  bool is_exam;
  bool attendance;
  Hadithtasmi3({
    required this.session_id,
    required this.student_id,
    required this.book_id,
    required this.from_hadith,
    required this.to_hadith,
    required this.is_counted,
    required this.is_exam,
    required this.attendance,
  });

  Hadithtasmi3 copyWith({
    num? session_id,
    num? student_id,
    num? book_id,
    num? from_hadith,
    num? to_hadith,
    bool? is_counted,
    bool? is_exam,
    bool? attendance,
  }) {
    return Hadithtasmi3(
      session_id: session_id ?? this.session_id,
      student_id: student_id ?? this.student_id,
      book_id: book_id ?? this.book_id,
      from_hadith: from_hadith ?? this.from_hadith,
      to_hadith: to_hadith ?? this.to_hadith,
      is_counted: is_counted ?? this.is_counted,
      is_exam: is_exam ?? this.is_exam,
      attendance: attendance ?? this.attendance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'session_id': session_id,
      'student_id': student_id,
      'book_id': book_id,
      'from_hadith': from_hadith,
      'to_hadith': to_hadith,
      'is_counted': is_counted,
      'is_exam': is_exam,
      'attendance': attendance,
    };
  }

  factory Hadithtasmi3.fromMap(Map<String, dynamic> map) {
    return Hadithtasmi3(
      session_id: map['session_id'] as num,
      student_id: map['student_id'] as num,
      book_id: map['book_id'] as num,
      from_hadith: map['from_hadith'] as num,
      to_hadith: map['to_hadith'] as num,
      is_counted: map['is_counted'] as bool,
      is_exam: map['is_exam'] as bool,
      attendance: map['attendance'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hadithtasmi3.fromJson(String source) => Hadithtasmi3.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Hadithtasmi3(session_id: $session_id, student_id: $student_id, book_id: $book_id, from_hadith: $from_hadith, to_hadith: $to_hadith, is_counted: $is_counted, is_exam: $is_exam, attendance: $attendance)';
  }

  @override
  bool operator ==(covariant Hadithtasmi3 other) {
    if (identical(this, other)) return true;
  
    return 
      other.session_id == session_id &&
      other.student_id == student_id &&
      other.book_id == book_id &&
      other.from_hadith == from_hadith &&
      other.to_hadith == to_hadith &&
      other.is_counted == is_counted &&
      other.is_exam == is_exam &&
      other.attendance == attendance;
  }

  @override
  int get hashCode {
    return session_id.hashCode ^
      student_id.hashCode ^
      book_id.hashCode ^
      from_hadith.hashCode ^
      to_hadith.hashCode ^
      is_counted.hashCode ^
      is_exam.hashCode ^
      attendance.hashCode;
  }
}
