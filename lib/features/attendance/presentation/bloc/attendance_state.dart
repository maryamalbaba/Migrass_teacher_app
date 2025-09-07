import 'package:equatable/equatable.dart';
import '../../data/model/attendance_model.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();
  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {
  const AttendanceInitial();
}

class AttendanceLoading extends AttendanceState {
  const AttendanceLoading();
}

class AttendanceError extends AttendanceState {
  final String message;
  const AttendanceError(this.message);

  @override
  List<Object?> get props => [message];
}

/// الحالة الرئيسية بعد التحميل
class AttendanceLoaded extends AttendanceState {
  final int sessionId;
  final List<AttendanceModel> attendances;

  /// لإظهار حالة الإرسال (تحديث)
  final bool isSubmitting;

  /// نجح الإرسال للتو (تصلح لاظهار SnackBar)
  final bool submitSuccess;

  final String? submitMessage;

  const AttendanceLoaded({
    required this.sessionId,
    required this.attendances,
    this.isSubmitting = false,
    this.submitSuccess = false,
    this.submitMessage,
  });

  AttendanceLoaded copyWith({
    int? sessionId,
    List<AttendanceModel>? attendances,
    bool? isSubmitting,
    bool? submitSuccess,
    String? submitMessage,
  }) {
    return AttendanceLoaded(
      sessionId: sessionId ?? this.sessionId,
      attendances: attendances ?? this.attendances,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      submitMessage: submitMessage,
    );
  }

  @override
  List<Object?> get props =>
      [sessionId, attendances, isSubmitting, submitSuccess, submitMessage];
}
