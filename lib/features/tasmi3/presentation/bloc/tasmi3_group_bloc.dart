import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tasmi3_group_event.dart';
part 'tasmi3_group_state.dart';

class Tasmi3GroupBloc extends Bloc<Tasmi3GroupEvent, Tasmi3GroupState> {
  Tasmi3GroupBloc() : super(Tasmi3GroupInitial()) {
    on<Tasmi3GroupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
