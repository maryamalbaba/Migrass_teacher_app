// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../showstudent/data/source/remote/remote.dart';
// import '../../../showstudent/presentation/bloc/show_students_bloc.dart';
// import '../../data/model/exam_model.dart';
//
//
//
// class MarkPage extends StatelessWidget {
//   final ExamModel examModel;
//   const MarkPage({super.key, required this.examModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality( // لضبط اتجاه RTL مثل التصميم
//       textDirection: TextDirection.rtl,
//       child: BlocProvider(
//         create: (context) => ShowStudentsBloc(service: ShowCircle())
//           ..add(ShowStudentevent(id: examModel.circleId)),
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black87,
//             title: const Text('قائمة الطلاب'),
//             centerTitle: true,
//           ),
//           body: BlocBuilder<ShowStudentsBloc, ShowStudentsState>(
//             builder: (context, state) {
//               if (state is LoadingShowStudent) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is SucceseShowStudent) {
//                 final students = state.list;
//
//                 return SingleChildScrollView(
//                   padding: const EdgeInsets.all(16),
//                   child: Center(
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(maxWidth: 680),
//                       child: Container(
//                         padding: const EdgeInsets.only(bottom: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(24),
//                           border: Border.all(color: Colors.green.shade300, width: 2),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 12),
//                             Text(
//                               'ادخال علامات الطلبة',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.green.shade700,
//                                 shadows: const [
//                                   Shadow(blurRadius: 1, offset: Offset(0, 1), color: Colors.black26),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             const Divider(height: 1),
//
//                             // الصفوف
//                             ...List.generate(students.length, (i) {
//                               final s = students[i];
//                               final name = '${s.first_name} ${s.last_name}';
//                               return Column(
//                                 children: [
//                                   StudentMarkTile(
//                                     name: name,
//                                     initialMark: '0',              // غيّر القيمة الافتراضية عند الحاجة
//                                     statusText: 'لم يتم التقديم', // النص تحت الاسم
//                                     // لون المؤشر (مثال: اجعل سطر معيّن أحمر):
//                                     statusColor: i == 2 ? Colors.red : Colors.grey,
//                                     onChanged: (val) {
//                                       // TODO: خزّن/حدّث علامة الطالب هنا
//                                     },
//                                   ),
//                                   if (i != students.length - 1)
//                                     Divider(height: 1, color: Colors.grey.shade300),
//                                 ],
//                               );
//                             }),
//
//                             const SizedBox(height: 16),
//                             SizedBox(
//                               width: 140,
//                               height: 44,
//                               child: ElevatedButton(
//                                 onPressed: () {
//
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green.shade600,
//                                   shape: const StadiumBorder(),
//                                   elevation: 0,
//                                 ),
//                                 child: const Text('ارسال', style: TextStyle(fontSize: 16)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               } else if (state is ErrorShowStudent) {
//                 return const Center(child: Text('حصل خطأ أثناء تحميل الطلاب'));
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class StudentMarkTile extends StatelessWidget {
//   final String name;
//   final String initialMark;
//   final String statusText;
//   final Color statusColor; // أحمر/رمادي… حسب الحالة
//   final ValueChanged<String>? onChanged;
//
//   const StudentMarkTile({
//     super.key,
//     required this.name,
//     required this.initialMark,
//     required this.statusText,
//     required this.statusColor,
//     this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // اليمين: الاسم + الحالة
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 name,
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
//               ),
//               const SizedBox(height: 6),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.circle, size: 12, color: statusColor),
//                   const SizedBox(width: 6),
//                   Text(
//                     statusText,
//                     style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//           const Spacer(),
//
//           // اليسار: حقل العلامة
//           SizedBox(
//             width: 72,
//             child: TextFormField(
//               initialValue: initialMark,
//               textAlign: TextAlign.center,
//               // keyboardType: const TextInputType.numberWithOptions(decimal: false)34234
//               decoration: InputDecoration(
//                 // isDense: true,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 filled: true,
//                 fillColor: const Color(0xFFF6FAF6),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.green.shade200),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.green.shade400, width: 1.6),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onChanged: onChanged,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/services_locator.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/data/model/mark_model.dart';
import 'package:teacher/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:teacher/features/exam/presentation/bloc/exam_event.dart';
import 'package:teacher/features/exam/presentation/bloc/exam_state.dart';

import '../../../showstudent/data/source/remote/remote.dart';
import '../../../showstudent/presentation/bloc/show_students_bloc.dart';

class MarkPage extends StatefulWidget {
  final ExamModel examModel;
  const MarkPage({super.key, required this.examModel});

  @override
  State<MarkPage> createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  // نجمع جميع العلامات هنا: studentId -> MarkModel
  final Map<int, MarkModel> _marks = {};
  bool _seeded = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocProvider(
        providers: [
          // Bloc عرض الطلاب
          BlocProvider(
            create: (_) =>
            ShowStudentsBloc(service: ShowCircle())
              ..add(ShowStudentevent(id: widget.examModel.circleId)),
          ),
          // Bloc الامتحانات (لإرسال العلامات)
          BlocProvider(
            create: (_) => ExamBloc(sl(), sl(), sl(), sl()),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black87,
            centerTitle: true,
            title: const Text('إدخال علامات الطلبة'),
          ),

          // نستمع لنتيجة إرسال العلامات
          body: BlocListener<ExamBloc, ExamState>(
            listener: (context, state) {
              if (state is AddMarksLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جاري الإرسال...')),
                );
              } else if (state is AddMarksSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ العلامات بنجاح')),
                );
                Navigator.of(context).pop(); // ارجع للخلف إن أردت
              } else if (state is AddMarksError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.message)),
                );
              }
            },
            child: BlocBuilder<ShowStudentsBloc, ShowStudentsState>(
              builder: (context, state) {
                if (state is LoadingShowStudent) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorShowStudent) {
                  return const Center(child: Text('حصل خطأ أثناء تحميل الطلاب'));
                } else if (state is SucceseShowStudent) {
                  final students = state.list;

                  // نولّد قيَم افتراضية مرة واحدة: hasTakenExam=true و score=0
                  if (!_seeded) {
                    for (final s in students) {
                      final sid = (s.id ?? s.id) as int; // عدل حسب موديلك
                      _marks[sid] = MarkModel(
                        examId: widget.examModel.id,
                        studentId: sid,
                        score: 0,
                        hasTakenExam: true, // افتراضيًا حضر (دائرة خضراء)
                        notes: '',
                      );
                    }
                    _seeded = true;
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 680),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.green.shade300, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              Text(
                                'ادخال علامات الطلبة',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade700,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Divider(height: 1),

                              ...List.generate(students.length, (i) {
                                final s = students[i];
                                final name =
                                    '${s.first_name} ${s.last_name}'; // عدل حسب موديلك
                                final sid = (s.id ?? s.id) as int;

                                final mark = _marks[sid]!;
                                return Column(
                                  children: [
                                    StudentMarkTile(
                                      name: name,
                                      // الحالة: دائرة خضراء/حمراء
                                      hasTakenExam: mark.hasTakenExam,
                                      statusText: mark.hasTakenExam
                                          ? 'تم التقديم'
                                          : 'لم يتم التقديم',
                                      // قيمة العلامة
                                      score: mark.score,
                                      onToggleTaken: (value) {
                                        setState(() {
                                          // إذا صار False نخلي العلامة 0 ونعطّل الإدخال
                                          _marks[sid] = mark.copyWith(
                                            hasTakenExam: value,
                                            score: value ? mark.score : 0,
                                          );
                                        });
                                      },
                                      onScoreChanged: (val) {
                                        final parsed = int.tryParse(val) ?? 0;
                                        // (اختياري) ضبط النطاق 0..100
                                        final safe = parsed.clamp(0, 100);
                                        setState(() {
                                          _marks[sid] =
                                              mark.copyWith(score: safe);
                                        });
                                      },
                                    ),
                                    if (i != students.length - 1)
                                      Divider(
                                          height: 1,
                                          color: Colors.grey.shade300),
                                  ],
                                );
                              }),

                              const SizedBox(height: 16),
                              SizedBox(
                                width: 140,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // جهّز القائمة للإرسال
                                    final list = _marks.values
                                        .map((m) => m.copyWith(
                                      // إذا الطالب ما حضر خلي العلامة 0
                                      score: m.hasTakenExam
                                          ? m.score
                                          : 0,
                                    ))
                                        .toList();

                                    context.read<ExamBloc>().add(
                                      AddMarks(
                                        examId: widget.examModel.id,
                                        marks: list,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade600,
                                    shape: const StadiumBorder(),
                                    elevation: 0,
                                  ),
                                  child: const Text('ارسال',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class StudentMarkTile extends StatelessWidget {
  final String name;
  final bool hasTakenExam; // true=حضر (أخضر), false=لم يحضر (أحمر)
  final String statusText;
  final int score;
  final ValueChanged<bool> onToggleTaken;
  final ValueChanged<String> onScoreChanged;

  const StudentMarkTile({
    super.key,
    required this.name,
    required this.hasTakenExam,
    required this.statusText,
    required this.score,
    required this.onToggleTaken,
    required this.onScoreChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = hasTakenExam ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // اليمين: الاسم + الحالة (قابلة للتبديل بالضغط)
          InkWell(
            onTap: () => onToggleTaken(!hasTakenExam),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, size: 12, color: statusColor),
                      const SizedBox(width: 6),
                      Text(
                        statusText,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // اليسار: حقل العلامة (يتعطّل إذا لم يحضر)
          SizedBox(
            width: 72,
            child: TextFormField(
              // key: ValueKey('score_$name_$hasTakenExam_$score'),
              initialValue: score.toString(),
              enabled: hasTakenExam, // تعطيل إذا لم يحضر
              textAlign: TextAlign.center,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                filled: true,
                fillColor: const Color(0xFFF6FAF6),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.green.shade400, width: 1.6),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: onScoreChanged,
            ),
          ),
        ],
      ),
    );
  }
}
