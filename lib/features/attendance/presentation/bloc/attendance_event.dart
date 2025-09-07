import 'package:equatable/equatable.dart';

import '../../data/model/attendance_model.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
  @override
  List<Object?> get props => [];
}

/// جلب الحضور للجلسة
class AttendanceLoad extends AttendanceEvent {
  final int sessionId;
  const AttendanceLoad(this.sessionId);
  @override
  List<Object?> get props => [sessionId];
}

/// تعديل عنصر محليًا داخل القائمة (حسب الفهرس)
class AttendanceItemUpdated extends AttendanceEvent {
  final int index;
  final AttendanceModel updated;
  const AttendanceItemUpdated({required this.index, required this.updated});
  @override
  List<Object?> get props => [index, updated];
}

/// إرسال التعديلات للخادم (updateAttendance)
class AttendanceSubmit extends AttendanceEvent {
  const AttendanceSubmit();
}
