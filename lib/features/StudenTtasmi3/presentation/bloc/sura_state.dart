// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sura_bloc.dart';

sealed class SuraState extends Equatable {
  const SuraState();

  @override
  List<Object> get props => [];
}

final class SuraInitial extends SuraState {}

class GetSuraSucess extends SuraState {
  final List<SuraModel> l;
  GetSuraSucess({
    required this.l,
  });
}

class GetSuraLoading extends SuraState {}

class GetSuraFailed extends SuraState {}
