import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/features/StudenTtasmi3/data/Models/SuraModel.dart';
import 'package:teacher/features/StudenTtasmi3/domain/usecase/usecase_sura.dart';

part 'sura_event.dart';
part 'sura_state.dart';



class SuraBloc extends Bloc<SuraEvent, SuraState> {
  final GetAllSurasUseCase usecase;

  SuraBloc(this.usecase) : super(SuraInitial()) {
    on<GetsuraEvent>(_onGetSuras);
  }

  Future<void> _onGetSuras(
    GetsuraEvent event,
    Emitter<SuraState> emit,
  ) async {
    emit(GetSuraLoading());

    final result = await usecase(); 

    result.fold(
      (left) {
        print(left.message);
        emit(GetSuraFailed()); 
      },
      (r) {
        print("success in bloc");
      print(r);
        emit(GetSuraSucess(l: r));
      },
    );
  }
}
