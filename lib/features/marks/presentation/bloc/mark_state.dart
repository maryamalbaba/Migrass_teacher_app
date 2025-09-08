import 'package:equatable/equatable.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/marks/data/model/mark_model.dart';

abstract class MarkState extends Equatable {
  const MarkState();
  @override
  List<Object?> get props => [];
}

class MarkInitial extends MarkState {}

class MarkLoading extends MarkState {}

/// الحالة الرئيسية لعرض وتعديل القائمة
class MarkLoaded extends MarkState {
  final List<MarkModel> marks;
  const MarkLoaded({required this.marks});

  @override
  List<Object?> get props => [marks];
}

class MarkSubmitting extends MarkState {}

class MarkSubmitted extends MarkState {
  const MarkSubmitted();
}

class MarkError extends MarkState {
  final ErrorModel error;
  const MarkError({required this.error});

  @override
  List<Object?> get props => [error];
}
