// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:teacher/features/records/data/models/student.dart';
import 'package:teacher/features/records/data/models/sura_record.dart';

class RecordModel {
  num id;
  num student_id;
  String file;
  num surah_id;
  num from_ayah_id;
  num to_ayah_id;
  Studentaudio studentaudio;
  SuraRecord sura_record;
  RecordModel({
    required this.id,
    required this.student_id,
    required this.file,
    required this.surah_id,
    required this.from_ayah_id,
    required this.to_ayah_id,
    required this.studentaudio,
    required this.sura_record,
  });

  RecordModel copyWith({
    num? id,
    num? student_id,
    String? file,
    num? surah_id,
    num? from_ayah_id,
    num? to_ayah_id,
    Studentaudio? studentaudio,
    SuraRecord? sura_record,
  }) {
    return RecordModel(
      id: id ?? this.id,
      student_id: student_id ?? this.student_id,
      file: file ?? this.file,
      surah_id: surah_id ?? this.surah_id,
      from_ayah_id: from_ayah_id ?? this.from_ayah_id,
      to_ayah_id: to_ayah_id ?? this.to_ayah_id,
      studentaudio: studentaudio ?? this.studentaudio,
      sura_record: sura_record ?? this.sura_record,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'student_id': student_id,
      'file': file,
      'surah_id': surah_id,
      'from_ayah_id': from_ayah_id,
      'to_ayah_id': to_ayah_id,
      // Align keys with API response structure
      'student': studentaudio.toMap(),
      'surah': sura_record.toMap(),
    };
  }

  factory RecordModel.fromMap(Map<String, dynamic> map) {
    final dynamic studentRaw = map['student'];
    final dynamic surahRaw = map['surah'];

    return RecordModel(
      id: map['id'] as num,
      student_id: map['student_id'] as num,
      file: map['file'] as String,
      surah_id: map['surah_id'] as num,
      from_ayah_id: map['from_ayah_id'] as num,
      to_ayah_id: map['to_ayah_id'] as num,
      // Safely parse nested objects; fall back to empty values if null/missing
      studentaudio: studentRaw is Map<String, dynamic>
          ? Studentaudio.fromMap(studentRaw)
          : Studentaudio(first_name: '', last_name: ''),
      sura_record: surahRaw is Map<String, dynamic>
          ? SuraRecord.fromMap(surahRaw)
          : SuraRecord(name: ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecordModel.fromJson(String source) =>
      RecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RecordModel(id: $id, student_id: $student_id, file: $file, surah_id: $surah_id, from_ayah_id: $from_ayah_id, to_ayah_id: $to_ayah_id, studentaudio: $studentaudio, sura_record: $sura_record)';
  }

  @override
  bool operator ==(covariant RecordModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.student_id == student_id &&
        other.file == file &&
        other.surah_id == surah_id &&
        other.from_ayah_id == from_ayah_id &&
        other.to_ayah_id == to_ayah_id &&
        other.studentaudio == studentaudio &&
        other.sura_record == sura_record;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        student_id.hashCode ^
        file.hashCode ^
        surah_id.hashCode ^
        from_ayah_id.hashCode ^
        to_ayah_id.hashCode ^
        studentaudio.hashCode ^
        sura_record.hashCode;
  }
}
