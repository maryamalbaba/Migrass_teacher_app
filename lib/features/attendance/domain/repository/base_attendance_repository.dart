import 'package:dartz/dartz.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';

import '../../data/model/attendance_model.dart';

abstract class BaseAttendanceRepository {
  Future<Either<String?, List<AttendanceModel>>> getAttendance(int sessionId);

  Future<Either<String?, dynamic>> updateAttendance(
    int sessionId,
    List<AttendanceModel> attendances,
  );
}
