part of 'send_tasmi3_bloc.dart';

sealed class SendTasmi3State extends Equatable {
  const SendTasmi3State();
  
  @override
  List<Object> get props => [];
}

final class SendTasmi3Initial extends SendTasmi3State {}


class SendTasmi3Loading extends SendTasmi3State {}
class SendTasmi3Success extends SendTasmi3State {}
class SendTasmi3Error extends SendTasmi3State {
  final String message;
  SendTasmi3Error(this.message);}