import 'package:get_it/get_it.dart';
import 'package:teacher/features/lessons/data/data_source/lesson_data_source.dart';
import 'package:teacher/features/lessons/data/repository/lesson_repository.dart';
import 'package:teacher/features/lessons/domain/repository/base_lesson_repository.dart';
import 'package:teacher/features/lessons/domain/usecases/get_lesson_usecase.dart';
import 'package:teacher/features/session_lesson/data/data_source/lesson_data_source.dart';
import 'package:teacher/features/session_lesson/data/repository/session_repository.dart';
import 'package:teacher/features/session_lesson/domain/repository/base_session_repository.dart';
import 'package:teacher/features/session_lesson/domain/usecases/create_session_usecase.dart';
import 'package:teacher/features/session_lesson/domain/usecases/get_session_usecase.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// circle
    sl.registerLazySingleton<GetLessonUseCase>(() => GetLessonUseCase(sl()));
    sl.registerLazySingleton<BaseLessonRepository>(
      () => LessonRepository(sl()),
    );
    sl.registerLazySingleton<BaseLessonRemoteDataSource>(
      () => LessonDataSource(),
    );


    /// session
    sl.registerLazySingleton<GetSessionUseCase>(() => GetSessionUseCase(sl()));
    sl.registerLazySingleton<CreateSessionUseCase>(() => CreateSessionUseCase(sl()));
    sl.registerLazySingleton<BaseSessionRepository>(
          () => SessionRepository(sl()),
    );
    sl.registerLazySingleton<BaseSessionRemoteDataSource>(
          () => SessionDataSource(),
    );

  }
}
