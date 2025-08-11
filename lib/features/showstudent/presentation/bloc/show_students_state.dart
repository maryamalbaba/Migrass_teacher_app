// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_students_bloc.dart';

sealed class ShowStudentsState extends Equatable {
  const ShowStudentsState();

  @override
  List<Object> get props => [];
}

final class ShowStudentsInitial extends ShowStudentsState {}

class SucceseShowStudent extends ShowStudentsState {
  List<StudentModel> list;
  SucceseShowStudent({
    required this.list,
  });
}

class ErrorShowStudent extends ShowStudentsState {}

class LoadingShowStudent extends ShowStudentsState {}
