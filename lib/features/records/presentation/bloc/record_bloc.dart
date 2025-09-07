import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/features/records/data/models/record_model.dart';
import 'package:teacher/features/records/domain/usecase/record_usecase.dart';

part 'record_event.dart';
part 'record_state.dart';
class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final GetRecordsUseCase getRecordsUseCase;

  RecordBloc(this.getRecordsUseCase) : super(RecordInitial()) {
    on<FetchRecords>((event, emit) async {
      emit(RecordLoading());
      final result = await getRecordsUseCase();
      result.fold(
        (error) => emit(RecordError(error.message)),
        (records) => emit(RecordLoaded(records)),
      );
    });
  }
}
