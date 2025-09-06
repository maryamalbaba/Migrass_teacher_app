part of 'sura_bloc.dart';

sealed class SuraEvent extends Equatable {
  const SuraEvent();

  @override
  List<Object> get props => [];
}


final  class GetsuraEvent extends  SuraEvent{ }