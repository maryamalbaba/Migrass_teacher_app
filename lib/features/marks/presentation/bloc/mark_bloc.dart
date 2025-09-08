import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/core/error/Error_model.dart';
import 'package:teacher/features/marks/data/model/mark_model.dart';
import 'package:teacher/features/exam/domain/usecases/add_marks_usecase.dart';
import '../../domain/usecase/get_mark_usecase.dart';
import 'mark_event.dart';
import 'mark_state.dart';

class MarkBloc extends Bloc<MarkEvent, MarkState> {
  final GetMarkUsecase getMarkUsecase;
  final AddMarksUsecase addMarksUsecase;

  MarkBloc(this.getMarkUsecase, this.addMarksUsecase) : super(MarkInitial()) {
    on<FetchMarks>(_onFetchMarks);
    on<ToggleHasTaken>(_onToggleHasTaken);
    on<ChangeScore>(_onChangeScore);
    on<SubmitMarks>(_onSubmitMarks);
  }

  Future<void> _onFetchMarks(FetchMarks event, Emitter<MarkState> emit) async {
    emit(MarkLoading());
    final result = await getMarkUsecase.execute(event.examId);
    emit(result.fold(
          (err) => MarkError(error: ErrorModel(message: err?.toString() ?? 'خطأ غير معروف')),
          (marks) => MarkLoaded(marks: marks),
    ));
  }

  void _onToggleHasTaken(ToggleHasTaken event, Emitter<MarkState> emit) {
    if (state is! MarkLoaded) return;
    final current = (state as MarkLoaded).marks;
    final updated = current.map((m) {
      if (m.studentId == event.studentId) {
        // إذا لم يحضر، نثبت الدرجة على 0
        return m.copyWith(
          hasTakenExam: event.value,
          score: event.value ? m.score : 0,
        );
      }
      return m;
    }).toList();
    emit(MarkLoaded(marks: updated));
  }

  void _onChangeScore(ChangeScore event, Emitter<MarkState> emit) {
    if (state is! MarkLoaded) return;
    final current = (state as MarkLoaded).marks;
    final updated = current.map((m) {
      if (m.studentId == event.studentId) {
        return m.copyWith(score: event.score);
      }
      return m;
    }).toList();
    emit(MarkLoaded(marks: updated));
  }

  Future<void> _onSubmitMarks(SubmitMarks event, Emitter<MarkState> emit) async {
    if (state is! MarkLoaded) return;
    final current = (state as MarkLoaded).marks;

    emit(MarkSubmitting());
    final res = await addMarksUsecase.execute(event.examId, current);
    await res.fold(
          (err) async => emit(MarkError(error: ErrorModel(message: err?.toString() ?? 'فشل الحفظ'))),
          (_) async {
        // بعد الحفظ نعمل Refresh للقائمة من السيرفر
        final refresh = await getMarkUsecase.execute(event.examId);
        refresh.fold(
              (err) => emit(MarkError(error: ErrorModel(message: err?.toString() ?? 'فشل التحديث بعد الحفظ'))),
              (marks) {
            // نرسل إشارة نجاح (للسنackbar) ثم نرجع للقائمة المحدثة
            emit(const MarkSubmitted());
            emit(MarkLoaded(marks: marks));
          },
        );
      },
    );
  }
}
