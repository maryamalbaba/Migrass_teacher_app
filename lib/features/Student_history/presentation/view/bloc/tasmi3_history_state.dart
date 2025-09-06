// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasmi3_history_bloc.dart';

sealed class Tasmi3HistoryState extends Equatable {
  const Tasmi3HistoryState();

  @override
  List<Object> get props => [];
}

final class Tasmi3HistoryInitial extends Tasmi3HistoryState {}

class loadingHistoryState extends Tasmi3HistoryState {}

class SuccestTasmi3History extends Tasmi3HistoryState {
  final List<Tasmi3HistoryModel> items;
  SuccestTasmi3History( {
    required this.items,
  });
}

class ErrorTasmi3History extends Tasmi3HistoryState {
  final String message;
  ErrorTasmi3History({
    required this.message,
  });
}
