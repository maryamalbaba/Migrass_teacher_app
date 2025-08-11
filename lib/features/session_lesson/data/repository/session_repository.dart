import 'package:dartz/dartz.dart';

import 'package:teacher/features/lessons/data/data_source/lesson_data_source.dart';
import 'package:teacher/features/lessons/data/model/lesson_model.dart';
import 'package:teacher/features/lessons/domain/repository/base_lesson_repository.dart';
import 'package:teacher/features/session_lesson/data/data_source/lesson_data_source.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';
import 'package:teacher/features/session_lesson/domain/repository/base_session_repository.dart';

class SessionRepository extends BaseSessionRepository {
  final BaseSessionRemoteDataSource baseSessionRemoteDataSource;

  SessionRepository(this.baseSessionRemoteDataSource);

  @override
  Future<Either<String?, List<SessionModel>>> getSession(int circleId) async{
    final result = await baseSessionRemoteDataSource.getSession(circleId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<String?, dynamic>> createSession( int circleId, SessionRequestModel session) async{
    final result = await baseSessionRemoteDataSource.createSession(circleId,session);
    return result.fold((l) => Left(l), (r) => Right(r));
  }


}
