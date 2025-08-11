import 'package:dartz/dartz.dart';

import 'package:teacher/features/lessons/data/data_source/lesson_data_source.dart';
import 'package:teacher/features/lessons/data/model/lesson_model.dart';
import 'package:teacher/features/lessons/domain/repository/base_lesson_repository.dart';

class LessonRepository extends BaseLessonRepository {
  final BaseLessonRemoteDataSource baseLessonRemoteDataSource;

  LessonRepository(this.baseLessonRemoteDataSource);

  @override
  Future<Either<String?, List<LessonModel>>> getLesson() async{
    final result = await baseLessonRemoteDataSource.getLesson();
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}
