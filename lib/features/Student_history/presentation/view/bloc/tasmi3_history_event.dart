// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasmi3_history_bloc.dart';

sealed class Tasmi3HistoryEvent extends Equatable {
  const Tasmi3HistoryEvent();

  @override
  List<Object> get props => [];
}


class GetTasmi3History extends Tasmi3HistoryEvent {
  final String studentId;
  final HalaqaType type;
  GetTasmi3History({
    required this.studentId,
    required this.type,
  });
}
