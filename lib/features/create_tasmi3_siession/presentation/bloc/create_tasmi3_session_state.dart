part of 'create_tasmi3_session_bloc.dart';

sealed class CreateTasmi3SessionState extends Equatable {
  const CreateTasmi3SessionState();

  @override
  List<Object> get props => [];
}

final class CreateTasmi3SessionInitial extends CreateTasmi3SessionState {}

final class SuucessCreateTasmi3Session extends CreateTasmi3SessionState {

 final Tasmi3Session newSession;

  SuucessCreateTasmi3Session( this.newSession);

}

final class FailedTasmi3Session extends CreateTasmi3SessionState {}

final class LoadingTasmi3Session extends CreateTasmi3SessionState {}
