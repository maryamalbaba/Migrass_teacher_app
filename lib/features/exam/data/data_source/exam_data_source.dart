import 'package:dartz/dartz.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/data/model/mark_model.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/enums/api_method.dart';
import '../../../../core/resource/api_manager.dart';

abstract class BaseExamRemoteDataSource{
  Future<Either<String?, List<ExamModel>>> getExam(int circleId);
  Future<Either<String?, dynamic>> createExam(int circleId,ExamModel exam);
  Future<Either<String?, dynamic>> updateExam(ExamModel exam);
  Future<Either<String?, List<MarkModel>>> addMarks( int exam,List<MarkModel> marks);
}

class ExamDataSource extends BaseExamRemoteDataSource {
  @override
  Future<Either<String?, List<ExamModel>>> getExam(int circleId) async {
    final result = await ApiService.instance.makeRequest(
      method: ApiMethod.get,
      endPoint: ApiManager.exam+'getAll/'+circleId.toString(),
    );

    return result.fold(
          (l) => Left(l.toString()),
          (r) =>
          Right(
            List<ExamModel>.from(
              (r['data'] as List).map((e) => ExamModel.fromJson(e)),
            ),
          ),
    );
  }

  @override
  Future<Either<String?, dynamic>> createExam(int circleId,
      ExamModel exam) async {
    final result = await ApiService.instance.makeRequest(
        method: ApiMethod.post,
        endPoint: ApiManager.exam +'examCreate/'+ circleId.toString(),
        body: {
          'title':exam.title,
          'date':exam.date,
          'description':exam.description
        }
    );

    return result.fold(
          (l) => Left(l.toString()),
          (r) =>
      const Right(
          unit
      ),
    );
  }

  @override
  Future<Either<String?, dynamic>> updateExam(
      ExamModel exam) async {
    final result = await ApiService.instance.makeRequest(
        method: ApiMethod.post,
        endPoint: ApiManager.exam +'update/'+ exam.id.toString(),
        body: {
          'title':exam.title,
          'date':exam.date,
          'description':exam.description
        }
    );

    return result.fold(
          (l) => Left(l.toString()),
          (r) =>
      const Right(
          unit
      ),
    );
  }

  @override
  Future<Either<String?, List<MarkModel>>> addMarks(int exam,List<MarkModel> marks)async {
    final result = await ApiService.instance.makeRequest(
        method: ApiMethod.post,
        endPoint: ApiManager.exam +'AddMarksCreate/'+ exam.toString(),
      body:{'data': marks.map((e)=>e.toJson()).toList()},

    );

    return result.fold(
          (l) => Left(l.toString()),
          (r) =>
      Right(
        List<MarkModel>.from(
          (r['data'] as List).map((e) => MarkModel.fromJson(e)),
        ),
      ),
    );
  }

}
