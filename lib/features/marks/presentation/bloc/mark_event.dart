import 'package:equatable/equatable.dart';

abstract class MarkEvent extends Equatable {
  const MarkEvent();

  @override
  List<Object?> get props => [];
}

/// جلب قائمة العلامات (تتضمن أسماء الطلاب من MarkModel)
class FetchMarks extends MarkEvent {
  final int examId;
  const FetchMarks(this.examId);

  @override
  List<Object?> get props => [examId];
}

/// تعديل حالة الحضور/الغياب لطالب معيّن (يؤثر فقط على الحالة الحالية قبل الحفظ)
class ToggleHasTaken extends MarkEvent {
  final int studentId;
  final bool value;
  const ToggleHasTaken({required this.studentId, required this.value});

  @override
  List<Object?> get props => [studentId, value];
}

/// تعديل الدرجة لطالب معيّن (يؤثر فقط على الحالة الحالية قبل الحفظ)
class ChangeScore extends MarkEvent {
  final int studentId;
  final int score; // سيتم Clamp من الواجهة 0..100
  const ChangeScore({required this.studentId, required this.score});

  @override
  List<Object?> get props => [studentId, score];
}

/// حفظ كل العلامات الحالية (يرسل للباك إند)
class SubmitMarks extends MarkEvent {
  final int examId;
  const SubmitMarks(this.examId);

  @override
  List<Object?> get props => [examId];
}
