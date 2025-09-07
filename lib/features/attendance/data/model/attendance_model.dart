import 'package:equatable/equatable.dart';

class AttendanceModel extends Equatable {
  final int studentId;
  final String firstName;
  final String lastName;
  final bool attendance;

  const AttendanceModel({
    this.studentId = 0,
    this.attendance = false,
    this.firstName = '',
    this.lastName = '',
  });

  /// النسخة المعدلة
  AttendanceModel copyWith({
    int? studentId,
    String? firstName,
    String? lastName,
    bool? attendance,
  }) {
    return AttendanceModel(
      studentId: studentId ?? this.studentId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      attendance: attendance ?? this.attendance,
    );
  }

  /// ميثود مساعدة لتبديل حالة الحضور
  AttendanceModel toggle() => copyWith(attendance: !attendance);

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      firstName: json['student']['first_name'] as String? ?? '',
      lastName: json['student']['last_name'] as String? ?? '',
      studentId: json['student']['id'] as int? ?? 0,
      attendance: json['attended'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'attendance': attendance,
    };
  }

  @override
  List<Object?> get props => [
    studentId,
    firstName,
    lastName,
    attendance,
  ];
}
