part of 'value_record_bloc.dart';

sealed class ValueRecordState extends Equatable {
  const ValueRecordState();
  
  @override
  List<Object> get props => [];
}

final class ValueRecordInitial extends ValueRecordState {}



class ValueRecordLoading extends ValueRecordState {}

class ValueRecordSuccess extends ValueRecordState {}

class ValueRecordFailure extends ValueRecordState {
  final String message;
  const ValueRecordFailure(this.message);
}