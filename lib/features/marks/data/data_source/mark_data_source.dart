import 'package:dartz/dartz.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/marks/data/model/mark_model.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/enums/api_method.dart';
import '../../../../core/resource/api_manager.dart';

abstract class BaseMarkRemoteDataSource{
  Future<Either<String?, List<MarkModel>>> getMarks(int examId);

  Future<Either<String?, dynamic>> addMarks( int exam,List<MarkModel> marks);
}

class MarkDataSource extends BaseMarkRemoteDataSource {
  @override
  Future<Either<String?, List<MarkModel>>> getMarks(int examId) async {
    final result = await ApiService.instance.makeRequest(
      method: ApiMethod.get,
      endPoint: ApiManager.exam + 'getAllMarks_teacher/' + examId.toString(),
    );

    return result.fold(
          (l) => Left(l.toString()),
          (r) {
        if (r['data'] != null && r['data'] is List) {
          return Right(
            List<MarkModel>.from(
              (r['data'] as List).map((e) => MarkModel.fromJson(e)),
            ),
          );
        } else {
          return const Right([]);
        }
      },
    );
  }




  @override
  Future<Either<String?, dynamic>> addMarks(int exam,List<MarkModel> marks)async {
    final result = await ApiService.instance.makeRequest(
      method: ApiMethod.post,
      endPoint: ApiManager.exam +'AddMarksCreate/'+ exam.toString(),
      body:{'data': marks.map((e)=>e.toJson()).toList()},

    );

    return result.fold(
          (l) => Left(l.toString()),
          (r) =>
          Right(
            unit
            ),

    );
  }

}
