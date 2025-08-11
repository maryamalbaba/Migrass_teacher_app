import 'package:dartz/dartz.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';

import '../repository/base_session_repository.dart';

class CreateSessionUseCase {
  final BaseSessionRepository baseSessionRepository;

  CreateSessionUseCase(this.baseSessionRepository);

  Future<Either<String?, dynamic>> execute(
    int studentId,
      SessionRequestModel session
  ) async {
    return await baseSessionRepository.createSession(
      studentId,
      session,
    );
  }
}
