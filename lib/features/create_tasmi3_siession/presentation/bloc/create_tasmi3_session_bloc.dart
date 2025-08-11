// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/circleSession.dart';
import 'package:teacher/features/create_tasmi3_siession/data/model/session.dart';

import 'package:teacher/features/create_tasmi3_siession/domain/usecase/createTasmi3usecase.dart';

part 'create_tasmi3_session_event.dart';
part 'create_tasmi3_session_state.dart';

class CreateTasmi3SessionBloc
    extends Bloc<CreateTasmi3SessionEvent, CreateTasmi3SessionState> {
  CreateTasmi3Usecase usecase;
  CreateTasmi3SessionBloc(
    this.usecase,
  ) : super(CreateTasmi3SessionInitial()) {
    on<CreateTasmi3SessionEventt>((event, emit) async {
      emit(LoadingTasmi3Session());
      final u = 
await usecase.execute(event.tasmi3session);
      u.fold((l) {
        emit(FailedTasmi3Session());
      }, (r) {
        emit(SuucessCreateTasmi3Session(event.tasmi3session));
      });
    });
  }
}
