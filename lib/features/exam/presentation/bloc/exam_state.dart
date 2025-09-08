

import 'package:flutter/cupertino.dart';

import '../../../../core/error/Error_model.dart';
import '../../data/model/exam_model.dart';
import '../../../marks/data/model/mark_model.dart';

@immutable
sealed class ExamState {}

final class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamSuccess extends ExamState {
  final List<ExamModel> exams;

  ExamSuccess({
    required this.exams,
  });
}

class ExamError extends ExamState {
  final ErrorModel error;

  ExamError({
    required this.error,
  });
}

class AddMarksLoading extends ExamState {}

class AddMarksSuccess extends ExamState {
  final List<MarkModel> savedMarks;
  AddMarksSuccess({required this.savedMarks});
}

class AddMarksError extends ExamState {
  final ErrorModel error;
  AddMarksError({required this.error});
}