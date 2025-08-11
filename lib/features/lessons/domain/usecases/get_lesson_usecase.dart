import 'package:dartz/dartz.dart';
import 'package:teacher/features/lessons/data/model/lesson_model.dart';
import 'package:teacher/features/lessons/domain/repository/base_lesson_repository.dart';



class GetLessonUseCase{
  final BaseLessonRepository baseLessonRepository;

  GetLessonUseCase(this.baseLessonRepository);

  Future<Either<String?, List<LessonModel>>> execute()async{
    return await baseLessonRepository.getLesson();
  }
}