import 'package:equatable/equatable.dart';

// تعريف الأحداث
abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

// حدث جلب قائمة الدوائر
class FetchLesson extends LessonEvent {}