import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../data/model/attendance_model.dart';
import '../../domain/usecase/get_attendance_usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetAttendanceUsecase getAttendanceUsecase;
  final UpdateAttendanceUsecase updateAttendanceUsecase;

  AttendanceBloc(
    this.getAttendanceUsecase,
    this.updateAttendanceUsecase,
  ) : super(const AttendanceInitial()) {
    on<AttendanceLoad>(_onLoad);
    on<AttendanceItemUpdated>(_onItemUpdated);
    on<AttendanceSubmit>(_onSubmit);
  }

  Future<void> _onLoad(
      AttendanceLoad event, Emitter<AttendanceState> emit) async {
    emit(const AttendanceLoading());

    final Either<String?, List<AttendanceModel>> res =
        await getAttendanceUsecase.getAttendance(event.sessionId);

    res.fold(
      (err) => emit(AttendanceError(err ?? 'حدث خطأ في جلب الحضور')),
      (list) =>
          emit(AttendanceLoaded(sessionId: event.sessionId, attendances: list)),
    );
  }

  void _onItemUpdated(
      AttendanceItemUpdated event, Emitter<AttendanceState> emit) {
    final current = state;
    if (current is AttendanceLoaded) {
      if (event.index < 0 || event.index >= current.attendances.length) return;

      final updatedList = List<AttendanceModel>.from(current.attendances);
      updatedList[event.index] = event.updated;

      emit(current.copyWith(
        attendances: updatedList,
        // تنظيف مؤشرات الإرسال السابقة لو كانت موجودة
        submitSuccess: false,
        submitMessage: null,
      ));
    }
  }

  Future<void> _onSubmit(
      AttendanceSubmit event, Emitter<AttendanceState> emit) async {
    final current = state;
    if (current is! AttendanceLoaded) return;

    emit(current.copyWith(
        isSubmitting: true, submitSuccess: false, submitMessage: null));

    final Either<String?, dynamic> res = await updateAttendanceUsecase
        .updateAttendance(current.sessionId, current.attendances);

    res.fold(
      (err) => emit(current.copyWith(
        isSubmitting: false,
        submitSuccess: false,
        submitMessage: err ?? 'فشل تحديث الحضور',
      )),
      (_) => emit(current.copyWith(
        isSubmitting: false,
        submitSuccess: true,
        submitMessage: 'تم حفظ الحضور بنجاح',
      )),
    );
  }
}
