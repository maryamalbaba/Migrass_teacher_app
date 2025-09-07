import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/get_session/data/models/session.dart';

abstract class RepositrySession {
  Future<Either<ErrorModel, List<Session>>> getAllTasmi3Session( num id);
}
