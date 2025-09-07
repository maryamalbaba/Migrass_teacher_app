import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/features/value_record/data/models/value_model.dart';
import 'package:teacher/features/value_record/domain/usecase/record_usecase.dart';


part 'value_record_event.dart';
part 'value_record_state.dart';

class ValueRecordBloc extends Bloc<ValueRecordEvent, ValueRecordState> {
  final SendValueRecordUseCase useCase;

  ValueRecordBloc(this.useCase) : super(ValueRecordInitial()) {
    on<SendValueRecordEvent>(_onSendValueRecord);
  }

  Future<void> _onSendValueRecord(
      SendValueRecordEvent event, Emitter<ValueRecordState> emit) async {
    emit(ValueRecordLoading());
    final result = await useCase(event.model, event.id);
    result.fold(
      (error) => emit(ValueRecordFailure(error.message)),
      (success) => emit(ValueRecordSuccess()),
    );
  }
}
