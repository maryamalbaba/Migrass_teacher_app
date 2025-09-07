import 'package:dartz/dartz.dart';
import 'package:teacher/features/attendance/domain/repository/base_attendance_repository.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/domain/repository/base_exam_repository.dart';

import '../../data/model/attendance_model.dart';

class GetAttendanceUsecase {
  final BaseAttendanceRepository baseAttendanceRepository;

  GetAttendanceUsecase(this.baseAttendanceRepository);

  Future<Either<String?, List<AttendanceModel>>> getAttendance(
      int sessionId) async {
    return await baseAttendanceRepository.getAttendance(sessionId);
  }
}

class UpdateAttendanceUsecase {
  final BaseAttendanceRepository baseAttendanceRepository;

  UpdateAttendanceUsecase(this.baseAttendanceRepository);

  Future<Either<String?, dynamic>> updateAttendance(
    int sessionId,
    List<AttendanceModel> attendances,
  ) async {
    return await baseAttendanceRepository.updateAttendance(
        sessionId, attendances);
  }
}
