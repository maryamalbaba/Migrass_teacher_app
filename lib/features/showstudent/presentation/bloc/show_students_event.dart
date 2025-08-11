// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_students_bloc.dart';

sealed class ShowStudentsEvent extends Equatable {
  const ShowStudentsEvent();

  @override
  List<Object> get props => [];

 
}
class ShowStudentevent extends ShowStudentsEvent {

  num id;
  ShowStudentevent({
    required this.id,
  });
 }
