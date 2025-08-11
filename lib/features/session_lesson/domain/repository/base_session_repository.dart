import 'package:dartz/dartz.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';

abstract class BaseSessionRepository {
  Future<Either<String?, List<SessionModel>>> getSession(int circleID);

  Future<Either<String?, dynamic>> createSession(
      int circleID, SessionRequestModel session);
}
