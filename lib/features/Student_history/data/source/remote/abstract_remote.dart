import 'package:dartz/dartz.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/Student_history/data/models/hadith_tasmi3.dart';
import 'package:teacher/features/Student_history/data/models/quran_tasimi3_history.dart';

abstract class StudentHistoryRemoteDataSource {
  Future<Either<ErrorModel,List<QuranTasimi3History>>> getQuranHistory({
    required String studentId,
  });

  Future<Either<ErrorModel,List<HadithHistoryTasmi3>>> getHadithHistory({
    required String studentId,
  });
}