import 'package:dartz/dartz.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';
import 'package:teacher/features/session_lesson/domain/repository/base_session_repository.dart';



class GetSessionUseCase {
  final BaseSessionRepository baseSessionRepository;

  GetSessionUseCase(this.baseSessionRepository);

  Future<Either<String?, List<SessionModel>>> execute(int circleId)async{
    return await baseSessionRepository.getSession(circleId);
  }
}