import 'package:dartz/dartz.dart';
import 'package:teacher/features/lessons/data/model/lesson_model.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/enums/api_method.dart';
import '../../../../core/resource/api_manager.dart';

abstract class BaseLessonRemoteDataSource{
 Future<Either<String?, List<LessonModel>>> getLesson();
}

class LessonDataSource extends BaseLessonRemoteDataSource {
 @override
  Future<Either<String?, List<LessonModel>>> getLesson() async {
  final result = await ApiService.instance.makeRequest(
   method: ApiMethod.get,
   endPoint: ApiManager.lesson,
  );

  return result.fold(
       (l) => Left(l.toString()),
       (r) => Right(
    List<LessonModel>.from(
     (r['data'][0]['circles'] as List).map((e) => LessonModel.fromJson(e)),
    ),
   ),
  );
 }
}
