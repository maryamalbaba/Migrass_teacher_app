import 'package:dartz/dartz.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/domain/repository/base_exam_repository.dart';


class GetExamUsecase {
  final BaseExamRepository baseExamRepository;

  GetExamUsecase(this.baseExamRepository);

  Future<Either<String?, List<ExamModel>>> execute(int circleId)async{
    return await baseExamRepository.getExam(circleId);
  }
}