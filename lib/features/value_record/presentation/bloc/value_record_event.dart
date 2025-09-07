part of 'value_record_bloc.dart';

sealed class ValueRecordEvent extends Equatable {
  const ValueRecordEvent();

  @override
  List<Object> get props => [];
}
class SendValueRecordEvent extends ValueRecordEvent {
  final ValuRecord model;
  final String id;

  const SendValueRecordEvent(this.model, this.id);
}