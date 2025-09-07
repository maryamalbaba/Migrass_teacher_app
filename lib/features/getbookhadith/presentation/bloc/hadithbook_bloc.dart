// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:teacher/features/getbookhadith/data/models/hadith_model.dart';
import 'package:teacher/features/getbookhadith/domain/usecase/gethadithusecase.dart';

part 'hadithbook_event.dart';
part 'hadithbook_state.dart';

class HadithbookBloc extends Bloc<HadithbookEvent, HadithbookState> {
    Gethadithusecase use;
  HadithbookBloc(
    this.use,
  ) : super(HadithbookInitial()) {
    on<FetchHadithEvent>((event, emit) async {
       emit(HadithLoading());
     final  result = await use.call;
     result.fold((error){
      emit(HadithError(error.message));
     },
     
     (hadith){
      emit(HadithSucces(hadith));
     });
    });
  }
}
