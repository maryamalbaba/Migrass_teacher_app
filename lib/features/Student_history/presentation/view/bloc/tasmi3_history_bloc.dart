// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:teacher/features/Student_history/data/models/tasmi3_model.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/Student_history/domain/usecase/student_tasmi3_history.dart';

part 'tasmi3_history_event.dart';
part 'tasmi3_history_state.dart';

class Tasmi3HistoryBloc extends Bloc<Tasmi3HistoryEvent, Tasmi3HistoryState> {

   final GetStudentHistory usecase;
  Tasmi3HistoryBloc(
    this.usecase,
  ) : super(Tasmi3HistoryInitial()) 
  {
    on<GetTasmi3History>((event, emit) async
     {
    
 emit(loadingHistoryState());
      final result = await usecase(event.studentId, event.type);
      result.fold(
        (l) => emit(ErrorTasmi3History(message:  l.message)),
        (r) => emit(SuccestTasmi3History(items: r)),
      );

    });
  }
}
