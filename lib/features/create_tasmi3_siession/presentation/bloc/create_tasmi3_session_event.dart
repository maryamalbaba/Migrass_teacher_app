// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_tasmi3_session_bloc.dart';

sealed class CreateTasmi3SessionEvent extends Equatable {
  const CreateTasmi3SessionEvent();

  @override
  List<Object> get props => [];
}
 
class CreateTasmi3SessionEventt extends CreateTasmi3SessionEvent {
  Tasmi3Session tasmi3session; 
  CreateTasmi3SessionEventt({
    required this.tasmi3session,
  });
 }
