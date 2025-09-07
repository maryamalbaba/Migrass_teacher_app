// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasmi3_session_bloc.dart';

sealed class Tasmi3SessionEvent extends Equatable {
  const Tasmi3SessionEvent();

  @override
  List<Object> get props => [];



  
}

class getSessionEvent extends Tasmi3SessionEvent {
  num id;

  getSessionEvent({
    required this.id,
   
  });

}
