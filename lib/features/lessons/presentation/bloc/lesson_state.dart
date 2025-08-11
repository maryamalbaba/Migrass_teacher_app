import 'package:equatable/equatable.dart';
import 'package:teacher/features/lessons/data/model/lesson_model.dart';

import '../../../../core/enums/controller_status.dart';


class LessonState extends Equatable {
  final ControllerStatus fetchLessonStatus;
  final String message;
  final List<LessonModel> circles;

  const LessonState({
    this.fetchLessonStatus = ControllerStatus.initial,
    this.message = '',
    this.circles = const [],
  });



  @override
  List<Object?> get props => [fetchLessonStatus, message, circles];
}