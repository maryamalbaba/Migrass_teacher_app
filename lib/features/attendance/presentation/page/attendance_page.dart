import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/core/widgets/appbar.dart';
import '../../../../core/resource/services_locator.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';

// استورد الـ usecases أو الـ repo حسب مشروعك
// import '../../domain/usecase/attendance_usecases.dart';

class AttendancePage extends StatelessWidget {
  final int sessionId;

  const AttendancePage({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttendanceBloc>(
      create: (_) => AttendanceBloc(sl(), sl())
        ..add(AttendanceLoad(sessionId)), // ← اطلق الحدث هنا
      child: Scaffold(
        appBar: SoftAppBar(title: "الطلاب"),
        body: BlocConsumer<AttendanceBloc, AttendanceState>(
          listener: (context, state) {
            if (state is AttendanceLoaded && state.submitMessage != null) {
              final ok = state.submitSuccess;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.submitMessage!),
                  backgroundColor: ok ? Colors.green : Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AttendanceError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is AttendanceLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: state.attendances.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final att = state.attendances[index];
                        return AttendanceItemTile(
                          title: '${att.firstName} ${att.lastName}',
                          present: att.attendance,
                          onTogglePresent: () {
                            context.read<AttendanceBloc>().add(
                                  AttendanceItemUpdated(
                                    index: index,
                                    updated: att.copyWith(
                                      attendance: !att.attendance,
                                    ),
                                  ),
                                );
                          },
                          onEdit: () {},
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: state.isSubmitting
                            ? null
                            : () => context
                                .read<AttendanceBloc>()
                                .add(const AttendanceSubmit()),
                        icon: state.isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.save),
                        label: Text(state.isSubmitting
                            ? 'جارٍ الحفظ...'
                            : 'حفظ التغييرات'),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

/// عنصر عرض الحضور في القائمة
class AttendanceItemTile extends StatelessWidget {
  final String title;
  final bool present;
  final VoidCallback onTogglePresent;
  final VoidCallback onEdit;

  const AttendanceItemTile({
    super.key,
    required this.title,
    required this.present,
    required this.onTogglePresent,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _StatusChip(present: present),
          const SizedBox(width: 10),
          _squareIconButton(
            icon: Icons.edit,
            onTap: onEdit,
          ),
          const SizedBox(width: 6),
          _squareIconButton(
            icon: Icons.check,
            onTap: onTogglePresent,
          ),
        ],
      ),
    );
  }

  Widget _squareIconButton(
      {required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.12),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 18, color: Colors.green),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool present;

  const _StatusChip({required this.present});

  @override
  Widget build(BuildContext context) {
    final bg =
        present ? Colors.green.withOpacity(.1) : Colors.red.withOpacity(.1);
    final fg = present ? Colors.green : Colors.red;
    final label = present ? 'حاضر' : 'غائب';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(100)),
      child:
          Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String msg;
  final VoidCallback onRetry;

  const _ErrorView({required this.msg, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(msg, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}
