import 'package:dartz/dartz.dart';
import 'package:teacher/features/attendance/data/data_source/attendance_data_source.dart';
import 'package:teacher/features/attendance/data/model/attendance_model.dart';
import 'package:teacher/features/attendance/domain/repository/base_attendance_repository.dart';
import 'package:teacher/features/exam/data/data_source/exam_data_source.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';

class AttendanceRepository extends BaseAttendanceRepository {
  final BaseAttendanceRemoteDataSource baseAttendanceRemoteDataSource;

  AttendanceRepository(this.baseAttendanceRemoteDataSource);

  @override
  Future<Either<String?, List<AttendanceModel>>> getAttendance(
      int sessionId) async {
    final result =
        await baseAttendanceRemoteDataSource.getAttendance(sessionId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String?, dynamic>> updateAttendance(
      int sessionId, List<AttendanceModel> attendances) async {
    final result = await baseAttendanceRemoteDataSource.updateAttendance(
        sessionId, attendances);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
