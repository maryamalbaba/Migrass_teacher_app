import 'package:equatable/equatable.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';

import '../../../marks/data/model/mark_model.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();

  @override
  List<Object?> get props => [];
}

class FetchExams extends ExamEvent {
  final int circleId;

  const FetchExams(this.circleId);

  @override
  List<Object?> get props => [circleId];
}

class CreateExam extends ExamEvent {
  final int circleId;
  final ExamModel exam;

  const CreateExam(this.circleId, this.exam);

  @override
  List<Object?> get props => [circleId, exam];
}

class UpdateExam extends ExamEvent {
  final ExamModel exam;

  const UpdateExam(this.exam);

  @override
  List<Object?> get props => [exam];
}

class AddMarks extends ExamEvent {
  final int examId;
  final List<MarkModel> marks;
  const AddMarks({required this.examId, required this.marks});

  @override
  List<Object?> get props => [examId, marks];
}