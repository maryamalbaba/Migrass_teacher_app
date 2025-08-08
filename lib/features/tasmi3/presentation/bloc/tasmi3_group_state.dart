// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasmi3_group_bloc.dart';

@immutable
sealed class Tasmi3GroupState {}

final class Tasmi3GroupInitial extends Tasmi3GroupState {}

class LoadingTasmi3GroupeState  extends Tasmi3GroupState {}

class SucessGetTasmi3GroupeState extends Tasmi3GroupState {
 
 List<Tasmi3Model> succeslist;
  SucessGetTasmi3GroupeState({
    required this.succeslist,
  });


}

class ErrorTasmi3GroupeState extends Tasmi3GroupState {
  ErrorModel e;
  ErrorTasmi3GroupeState({
    required this.e,
  });
}
