import 'package:get_it/get_it.dart';
import 'package:teacher/features/attendance/data/data_source/attendance_data_source.dart';
import 'package:teacher/features/attendance/data/repository/attendance_repository.dart';
import 'package:teacher/features/attendance/domain/repository/base_attendance_repository.dart';
import 'package:teacher/features/attendance/domain/usecase/get_attendance_usecase.dart';
import 'package:teacher/features/exam/data/data_source/exam_data_source.dart';
import 'package:teacher/features/exam/data/repository/exam_repository.dart';
import 'package:teacher/features/exam/domain/repository/base_exam_repository.dart';
import 'package:teacher/features/exam/domain/usecases/add_exam_usecase.dart';
import 'package:teacher/features/exam/domain/usecases/add_marks_usecase.dart';
import 'package:teacher/features/exam/domain/usecases/get_exam_usecase.dart';
import 'package:teacher/features/exam/domain/usecases/update_exam_usecase.dart';
import 'package:teacher/features/lessons/data/data_source/lesson_data_source.dart';
import 'package:teacher/features/lessons/data/repository/lesson_repository.dart';
import 'package:teacher/features/lessons/domain/repository/base_lesson_repository.dart';
import 'package:teacher/features/lessons/domain/usecases/get_lesson_usecase.dart';
import 'package:teacher/features/marks/data/data_source/mark_data_source.dart';
import 'package:teacher/features/marks/data/repository/mark_repository.dart';
import 'package:teacher/features/marks/domain/repository/base_mark_repository.dart';
import 'package:teacher/features/marks/domain/usecase/get_mark_usecase.dart';
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

    /// exam
    sl.registerLazySingleton<GetExamUsecase>(() => GetExamUsecase(sl()));
    sl.registerLazySingleton<AddExamUsecase>(() => AddExamUsecase(sl()));
    sl.registerLazySingleton<UpdateExamUsecase>(() => UpdateExamUsecase(sl()));
    sl.registerLazySingleton<BaseExamRemoteDataSource>(
          () => ExamDataSource(),
    );
    sl.registerLazySingleton<BaseExamRepository>(
          () => ExamRepository(sl()),
    );


    /// attendance
    sl.registerLazySingleton<GetAttendanceUsecase>(() => GetAttendanceUsecase(sl()));
    sl.registerLazySingleton<UpdateAttendanceUsecase>(() => UpdateAttendanceUsecase(sl()));


    sl.registerLazySingleton<BaseAttendanceRemoteDataSource>(
          () => AttendanceDataSource(),
    );
    sl.registerLazySingleton<BaseAttendanceRepository>(
          () => AttendanceRepository(sl()),
    );
    /// marks
    sl.registerLazySingleton<GetMarkUsecase>(() => GetMarkUsecase(sl()));
    sl.registerLazySingleton<AddMarksUsecase>(() => AddMarksUsecase(sl()));

    sl.registerLazySingleton<BaseMarkRemoteDataSource>(
          () => MarkDataSource()
    );
    sl.registerLazySingleton<BaseMarkRepository>(
          () => MarkRepository(sl()),
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
