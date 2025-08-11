import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/showstudent/data/source/remote/remote.dart';
import 'package:teacher/features/tasmi3/data/models/student_model.dart';

part 'show_students_event.dart';
part 'show_students_state.dart';

class ShowStudentsBloc extends Bloc<ShowStudentsEvent, ShowStudentsState> {
  final ShowCircle service; 

  ShowStudentsBloc({required this.service}) : super(ShowStudentsInitial()) {
    on<ShowStudentevent>(_onShowStudents);
  }

  Future<void> _onShowStudents(
      ShowStudentevent event, Emitter<ShowStudentsState> emit) async {
    emit(LoadingShowStudent());

    try {
      final result = await service.remotservice(event.id);

      if (result is ErrorModel) {
        emit(ErrorShowStudent()); 
      } else if (result is List<StudentModel>) {
        emit(SucceseShowStudent(list: result));
      } else {
        emit(ErrorShowStudent());
      }
    } catch (e) {
      emit(ErrorShowStudent());
    }
  }
}
