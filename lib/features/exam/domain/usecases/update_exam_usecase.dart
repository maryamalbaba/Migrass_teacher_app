import 'package:dartz/dartz.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/domain/repository/base_exam_repository.dart';


class UpdateExamUsecase {
  final BaseExamRepository baseExamRepository;

  UpdateExamUsecase(this.baseExamRepository);

  Future<Either<String?, dynamic>> execute( ExamModel exam)async{
    return await baseExamRepository.updateExam( exam);
  }
}