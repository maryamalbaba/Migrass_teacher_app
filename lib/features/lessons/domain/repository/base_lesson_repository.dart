import 'package:dartz/dartz.dart';
import 'package:teacher/features/lessons/data/model/lesson_model.dart';


abstract class BaseLessonRepository{
  Future<Either<String?, List<LessonModel>>> getLesson();
}