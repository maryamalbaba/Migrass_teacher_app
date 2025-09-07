import 'package:dartz/dartz.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';

import '../../data/model/exam_model.dart';
import '../../data/model/mark_model.dart';

abstract class BaseExamRepository {
  Future<Either<String?, List<ExamModel>>> getExam(int circleId);
  Future<Either<String?, dynamic>> createExam(int circleId,ExamModel exam);
  Future<Either<String?, dynamic>> updateExam(ExamModel exam);
  Future<Either<String?, List<MarkModel>>> addMarks( int exam,List<MarkModel> marks);

}
