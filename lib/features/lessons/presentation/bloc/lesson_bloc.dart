import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/features/lessons/domain/usecases/get_lesson_usecase.dart';

import '../../../../core/enums/controller_status.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetLessonUseCase getLessonUseCase;

  LessonBloc(this.getLessonUseCase) : super(LessonState()) {
    on<LessonEvent>((event, emit) async {
      emit(LessonState(fetchLessonStatus: ControllerStatus.loading));
      final result =await getLessonUseCase.execute();

      result.fold(
        (l) {
          emit(
            LessonState(
              fetchLessonStatus: ControllerStatus.error,
              message: l.toString(),
            ),
          );
        },
        (r) {
          emit(
            LessonState(
              fetchLessonStatus: ControllerStatus.loaded,
              circles: r,
            ),
          );
        },
      );
    });
  }
}
