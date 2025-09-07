part of 'send_tasmi3_bloc.dart';

sealed class SendTasmi3Event extends Equatable {
  const SendTasmi3Event();

  @override
  List<Object> get props => [];
}
class SendTasmi3  extends SendTasmi3Event{
  final HalaqaType type;
  final TasmiSend model;
  SendTasmi3({required this.type, required this.model});
}