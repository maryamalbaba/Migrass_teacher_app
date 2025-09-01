// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/core/error/Error_model.dart';

import 'package:teacher/features/create_tasmi3_siession/presentation/bloc/create_tasmi3_session_bloc.dart';
import 'package:teacher/features/get_session/data/models/session.dart';
import 'package:teacher/features/get_session/domain/usecase/sessiontasmi3.dart';

part 'tasmi3_session_event.dart';
part 'tasmi3_session_state.dart';

class Tasmi3SessionBloc extends Bloc<Tasmi3SessionEvent, Tasmi3SessionState> {
  GetAllTasmiSessionUseCase use_case;

  Tasmi3SessionBloc(
    this.use_case,
  ) : super(Tasmi3SessionInitial()) {
    on<getSessionEvent>((event, emit) async {
      // TODO: implement event handler

      emit(GetSessionloading());
      Either<ErrorModel, List<Session>> u = await use_case.call(event.id);
      return u.fold((l)
       {
        emit(GetSessionFailed());
      }, 
      (r)
     {

        emit(GetSessionSucces(list: r));



      });
    });
  }
}
