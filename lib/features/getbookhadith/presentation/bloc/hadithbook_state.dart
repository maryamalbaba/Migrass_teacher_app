part of 'hadithbook_bloc.dart';

sealed class HadithbookState extends Equatable {
  const HadithbookState();
  
  @override
  List<Object> get props => [];
}

final class HadithbookInitial extends HadithbookState {}
