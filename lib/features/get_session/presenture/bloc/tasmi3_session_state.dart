// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasmi3_session_bloc.dart';

sealed class Tasmi3SessionState extends Equatable {
  const Tasmi3SessionState();

  @override
  List<Object> get props => [];
}

final class Tasmi3SessionInitial extends Tasmi3SessionState {}

class GetSessionSucces extends Tasmi3SessionState {

  List<Session> list;
  GetSessionSucces({
    required this.list,
  });
}

class GetSessionFailed extends Tasmi3SessionState {}

class GetSessionloading extends Tasmi3SessionState {}

class GetSessionEmpty extends Tasmi3SessionState {}
