import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/Student_history/data/models/quran_tasimi3_history.dart';
import 'package:teacher/features/Student_history/data/models/tasmi3_model.dart';
import 'package:teacher/features/Student_history/data/source/remote/imp_remote.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/Student_history/domain/repo/repo.dart';

class HistoryTasmi3RepoImp implements StudentHistoryRepository {
  final StudentHistoryRemoteDataSourceImpl remotdata;

  HistoryTasmi3RepoImp({required this.remotdata});
  @override
  Future<Either<ErrorModel, List<Tasmi3HistoryModel>>> getStudentHistory(
      {required String studentId, required HalaqaType type}) async {
    try {
      if (type == HalaqaType.quran) {
        final result = await remotdata.getQuranHistory(studentId: studentId);

        return result;
      }

      if (type == HalaqaType.hadith) {
        final result = await remotdata.getHadithHistory(studentId: studentId);

        return result;
      }
      if (type == HalaqaType.talqen) {
        final result = await remotdata.getTalqeenHistory(studentId: studentId);

        return result;
      }

      return Left(ErrorModel(message: "Invalid HalaqaType"));
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
