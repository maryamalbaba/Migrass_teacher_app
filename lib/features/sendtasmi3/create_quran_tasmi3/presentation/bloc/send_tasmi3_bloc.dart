// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/data/models/tasmi_send.dart';
import 'package:teacher/features/sendtasmi3/create_quran_tasmi3/domin/usecase/usecase.dart';

part 'send_tasmi3_event.dart';
part 'send_tasmi3_state.dart';

class SendTasmi3Bloc extends Bloc<SendTasmi3Event, SendTasmi3State> {

  final SendTasmi3UseCase useCase;
  SendTasmi3Bloc(
    this.useCase,
  ) : super(SendTasmi3Initial()) {
    on<SendTasmi3>((event, emit) async {
     emit(SendTasmi3Loading());
      final result = await useCase.call(type: event.type, model: event.model);
      result.fold(
        (l) => emit(SendTasmi3Error(l.message)),
        (r) => emit(SendTasmi3Success()),
      );
    });
  }
}
