import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/tasmi3/data/models/tasmi3_model.dart';
import 'package:teacher/features/tasmi3/domain/use_case/get_tasmi3_group_usecase.dart';

part 'tasmi3_group_event.dart';
part 'tasmi3_group_state.dart';

class Tasmi3GroupBloc extends Bloc<Tasmi3GroupEvent, Tasmi3GroupState> {
  final GetAllTasmi3GroupUseCase usecase;
  Tasmi3GroupBloc(this.usecase) : super(Tasmi3GroupInitial()) {
    on<Tasmi3GroupEvent>((event, emit) async {
      emit(LoadingTasmi3GroupeState());
      final usecase1 = await usecase.call;

    return  usecase1.fold(
        
        (l) {
          print("l in bloc");
          emit(ErrorTasmi3GroupeState(e:ErrorModel(message: l.message) ));
        }, 
      
      (r) {
        print("succ in bloc");
        emit(SucessGetTasmi3GroupeState(succeslist: r));
        });
    });
  }
}
