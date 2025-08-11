import 'package:equatable/equatable.dart';
import 'package:teacher/features/session_lesson/data/model/session_model.dart';


// تعريف الأحداث
abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class FetchSessionEvent extends SessionEvent {
  final int circleId;

  const FetchSessionEvent({required this.circleId});
}

class CreateSessionEvent extends SessionEvent {
  final  SessionRequestModel session;
  final int circleId;

  const CreateSessionEvent({
    required this.session,
    required this.circleId,
  });
}





