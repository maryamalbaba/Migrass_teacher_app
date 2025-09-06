import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/Student_history/data/models/tasmi3_model.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/Student_history/domain/usecase/student_tasmi3_history.dart';

abstract class StudentHistoryRepository {
  Future<Either<ErrorModel, List<Tasmi3HistoryModel>>> getStudentHistory({
    required String studentId,
    required HalaqaType type,
  });
}