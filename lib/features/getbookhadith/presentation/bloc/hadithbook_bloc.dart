import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hadithbook_event.dart';
part 'hadithbook_state.dart';

class HadithbookBloc extends Bloc<HadithbookEvent, HadithbookState> {
  HadithbookBloc() : super(HadithbookInitial()) {
    on<HadithbookEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
