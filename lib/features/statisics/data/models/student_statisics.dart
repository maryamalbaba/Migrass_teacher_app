// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentStatisics {
  num attendance;
  num savedQuran;
  num savedHadith;
  StudentStatisics({
    required this.attendance,
    required this.savedQuran,
    required this.savedHadith,
  });

  StudentStatisics copyWith({
    num? attendance,
    num? savedQuran,
    num? savedHadith,
  }) {
    return StudentStatisics(
      attendance: attendance ?? this.attendance,
      savedQuran: savedQuran ?? this.savedQuran,
      savedHadith: savedHadith ?? this.savedHadith,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attendance': attendance,
      'savedQuran': savedQuran,
      'savedHadith': savedHadith,
    };
  }

  factory StudentStatisics.fromMap(Map<String, dynamic> map) {
    return StudentStatisics(
      attendance: map['attendance'] as num,
      savedQuran: map['savedQuran'] as num,
      savedHadith: map['savedHadith'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentStatisics.fromJson(String source) => StudentStatisics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StudentStatisics(attendance: $attendance, savedQuran: $savedQuran, savedHadith: $savedHadith)';

  @override
  bool operator ==(covariant StudentStatisics other) {
    if (identical(this, other)) return true;
  
    return 
      other.attendance == attendance &&
      other.savedQuran == savedQuran &&
      other.savedHadith == savedHadith;
  }

  @override
  int get hashCode => attendance.hashCode ^ savedQuran.hashCode ^ savedHadith.hashCode;
}
