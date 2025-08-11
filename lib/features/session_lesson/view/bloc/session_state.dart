import 'package:equatable/equatable.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';
import '../../../../core/enums/controller_status.dart';

class SessionState extends Equatable {
  final ControllerStatus fetchSessionStatus;
  final ControllerStatus createSessionStatus;
  final String message;
  final List<SessionModel> sessions;

  const SessionState({
    this.fetchSessionStatus = ControllerStatus.initial,
    this.createSessionStatus = ControllerStatus.initial,
    this.message = '',
    this.sessions = const [],
  });

  @override
  List<Object?> get props => [
        fetchSessionStatus,
        createSessionStatus,
        message,
        sessions,
      ];
}
