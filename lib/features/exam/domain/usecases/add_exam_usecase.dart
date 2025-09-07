import 'package:dartz/dartz.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/domain/repository/base_exam_repository.dart';


class AddExamUsecase {
  final BaseExamRepository baseExamRepository;

  AddExamUsecase(this.baseExamRepository);

  Future<Either<String?, dynamic>> execute(int circleId, ExamModel exam)async{
    return await baseExamRepository.createExam(circleId, exam);
  }
}