// data/datasources/student_history_remote_ds_impl.dart
import 'package:dartz/dartz.dart';
import 'package:teacher/core/api/api_service.dart';
import 'package:teacher/core/enums/api_method.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/core/resource/api_manager.dart';
import 'package:teacher/features/Student_history/data/models/hadith_tasmi3.dart';
import 'package:teacher/features/Student_history/data/models/quran_tasimi3_history.dart';
import 'package:teacher/features/Student_history/data/models/talqeen.dart';
import 'package:teacher/features/Student_history/data/source/remote/abstract_remote.dart';

class StudentHistoryRemoteDataSourceImpl
    implements StudentHistoryRemoteDataSource {
  StudentHistoryRemoteDataSourceImpl();

  @override
  Future<Either<ErrorModel, List<QuranTasimi3History>>> getQuranHistory({
    required String studentId,
  }) async {
    final result = await ApiService.instance.makeRequest(
        method: ApiMethod.get,
        endPoint: ApiManager.QuranHistoryApi + studentId);

    return result.fold((l) {
      return Left(
          ErrorModel(message: "some thing went wrong in tasmu3 quran student"));
    }, (r) {
      List<QuranTasimi3History> list = List.generate(r["data"].length,
          (index) => QuranTasimi3History.fromMap(r["data"][index]));
      return Right(list);
    });
  }

  @override
  Future<Either<ErrorModel, List<HadithHistoryTasmi3>>> getHadithHistory({
    required String studentId,
  }) async {
    final result = await ApiService.instance.makeRequest(
        method: ApiMethod.get,
        endPoint: ApiManager.HadithHistoryApi + studentId);

    return result.fold((l) {
      return Left(ErrorModel(message: "some thing went wrong in hadith"));
    }, (r) {
      List<HadithHistoryTasmi3> list = List.generate(r["data"].length,
          (index) => HadithHistoryTasmi3.fromMap(r["data"][index]));
      return Right(list);
    });
  }

  @override
  Future<Either<ErrorModel, List<Talqeen>>> getTalqeenHistory(
      {required String studentId}) async {
    final result = await ApiService.instance.makeRequest(
        method: ApiMethod.get,
        endPoint: ApiManager.talqeenHistoryApi+studentId);

    return result.fold((l) {
      return Left(
          ErrorModel(message: "some thing went wrong in tasmu3 quran student"));
    }, (r) {
      List<Talqeen> list = List.generate(
          r["data"].length, (index) => Talqeen.fromMap(r["data"][index]));
      return Right(list);
    });
  }
}
