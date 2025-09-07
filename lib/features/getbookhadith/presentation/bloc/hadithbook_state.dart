part of 'hadithbook_bloc.dart';

sealed class HadithbookState extends Equatable {
  const HadithbookState();
  
  @override
  List<Object> get props => [];
}

final class HadithbookInitial extends HadithbookState {}

class HadithLoading extends HadithbookState {}

class HadithSucces extends HadithbookState {
  final List<HadithModel> hadiths;
  HadithSucces(this.hadiths);
}

class HadithError extends HadithbookState {
  final String message;
  HadithError(this.message);
}