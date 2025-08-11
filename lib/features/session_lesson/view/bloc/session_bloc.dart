import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/features/session_lesson/domain/usecases/create_session_usecase.dart';
import 'package:teacher/features/session_lesson/domain/usecases/get_session_usecase.dart';
import '../../../../core/enums/controller_status.dart';
import 'session_event.dart';
import 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final GetSessionUseCase getSessionUseCase;
  final CreateSessionUseCase createSessionUseCase;

  SessionBloc(this.getSessionUseCase, this.createSessionUseCase)
      : super(const SessionState()) {
    on<FetchSessionEvent>((event, emit) async {
      emit(SessionState(fetchSessionStatus: ControllerStatus.loading));
      final result = await getSessionUseCase.execute(event.circleId);
      result.fold(
        (l) {
          emit(
            SessionState(
              fetchSessionStatus: ControllerStatus.error,
              message: l.toString(),
            ),
          );
        },
        (r) {
          emit(
            SessionState(
              fetchSessionStatus: ControllerStatus.loaded,
              sessions: r,
            ),
          );
        },
      );
    });
    on<CreateSessionEvent>((event, emit) async {
      emit(SessionState(createSessionStatus: ControllerStatus.loading));
      final result = await createSessionUseCase.execute(
        event.circleId,
        event.session,
      );
      result.fold(
        (l) {
          emit(
            SessionState(
              createSessionStatus: ControllerStatus.error,
              message: l.toString(),
            ),
          );
        },
        (r) {
          emit(
            SessionState(
              createSessionStatus: ControllerStatus.loaded,
            ),
          );
        },
      );
    });
  }
}
