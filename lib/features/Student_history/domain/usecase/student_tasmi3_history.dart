// domain/usecases/get_student_history.dart
import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/Student_history/data/models/tasmi3_model.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/Student_history/domain/repo/repo.dart';

class GetStudentHistory {
  final StudentHistoryRepository repo;
  GetStudentHistory(this.repo);

  Future<Either<ErrorModel, List<Tasmi3HistoryModel>>> call(
    final String studentId,
  final HalaqaType type,
  ) {
    return repo.getStudentHistory(studentId: studentId, type:type);
  }
}

