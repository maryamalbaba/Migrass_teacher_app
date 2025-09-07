part of 'record_bloc.dart';

sealed class RecordState extends Equatable {
  const RecordState();
  
  @override
  List<Object> get props => [];
}

final class RecordInitial extends RecordState {}

class RecordLoading extends RecordState {}

class RecordLoaded extends RecordState {
  final List<RecordModel> records;
  RecordLoaded(this.records);



}

class RecordError extends RecordState {
  final String message;
  RecordError(this.message);}