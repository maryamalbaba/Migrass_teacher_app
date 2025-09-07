import 'package:dartz/dartz.dart';
import 'package:teacher/features/attendance/presentation/page/attendance_page.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/enums/api_method.dart';
import '../../../../core/resource/api_manager.dart';
import '../model/attendance_model.dart';

abstract class BaseAttendanceRemoteDataSource {
  Future<Either<String?, List<AttendanceModel>>> getAttendance(int sessionId);

  Future<Either<String?, dynamic>> updateAttendance(
    int sessionId,
    List<AttendanceModel> attendances,
  );
}

class AttendanceDataSource extends BaseAttendanceRemoteDataSource {
  @override
  Future<Either<String?, List<AttendanceModel>>> getAttendance(
    int sessionId,
  ) async {
    final result = await ApiService.instance.makeRequest(
      method: ApiMethod.get,
      endPoint: ApiManager.lessonSession +
          "getAllStudentForAttendance/" +
          sessionId.toString(),
    );
    return result.fold(
      (l) => Left(l.toString()),
      (r) => Right(
        List<AttendanceModel>.from(
          (r['students'] as List).map((e) => AttendanceModel.fromJson(e)),
        ),
      ),
    );
  }

  @override
  Future<Either<String?, dynamic>> updateAttendance(
    int sessionId,
    List<AttendanceModel> challengeRequest,
  ) async {
    final result = await ApiService.instance.makeRequest(
      method: ApiMethod.post,
      endPoint: ApiManager.lessonSession +
          "createSessionAttendance/" +
          sessionId.toString(),
      body: {'data': challengeRequest.map((e) => e.toJson()).toList()},
    );

    return result.fold((l) => Left(l.toString()), (r) => Right(unit));
  }
}
