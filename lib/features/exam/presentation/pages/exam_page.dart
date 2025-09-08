import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/core/resource/services_locator.dart';
import 'package:teacher/core/widgets/appbar.dart';
import 'package:teacher/core/widgets/custom_appbar.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:teacher/features/exam/presentation/bloc/exam_event.dart';
import 'package:teacher/features/exam/presentation/bloc/exam_state.dart';
import 'package:teacher/features/session_lesson/view/widget/session_card.dart';
import '../widget/exam_card.dart';

class ExamPage extends StatelessWidget {
  final int circleId;

  const ExamPage({super.key, required this.circleId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExamBloc(sl(), sl(), sl(),sl())..add(FetchExams(circleId)),
      child: Scaffold(
        backgroundColor: veryLightGreen2,
        body: Column(
          children: [
            Container(
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagesManager.greenBcak),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              child: const SoftAppBar(title: 'الامتحانات',backgroundColor: Colors.transparent,),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: BlocBuilder<ExamBloc, ExamState>(
                  builder: (context, state) {
                    if (state is ExamLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ExamError) {
                      return Center(child: Text(state.error.message));
                    } else if (state is ExamSuccess) {
                      if (state.exams.isEmpty) {
                        return const Center(child: Text('لا توجد امتحانات'));
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: state.exams.length,
                        itemBuilder: (context, index) {
                          final exam = state.exams[index];
                          return SessionCard(
                            title: exam.title,
                            subtitle: exam.description ?? '',
                            onTap: () {
                              AppNavigator.instance.push(
                                name: RouteConst.marks,
                                extra: exam,
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<ExamBloc, ExamState>(
          builder: (context, state) {
            return InkWell(
              onTap: () => createExamDialog(context),
              child: Container(
                height: 66,
                width: 66,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: lightGreen1,
                ),
                child: const Icon(Icons.add, color: white, size: 40),
              ),
            );
          },
        ),
      ),
    );
  }

  void createExamDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<ExamBloc>(),
          child: AlertDialog(
            title: const Text('إنشاء امتحان جديد'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'العنوان'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'الوصف'),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                        labelText: 'التاريخ (YYYY-MM-DD)'),
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: dialogContext,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        dateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('إلغاء'),
              ),
              BlocConsumer<ExamBloc, ExamState>(
                listener: (context, state) {
                  if (state is ExamSuccess) {
                    // No need to trigger FetchExams here; ExamBloc handles it
                    Navigator.pop(dialogContext);
                  } else if (state is ExamError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    onPressed: state is ExamLoading
                        ? null
                        : () {
                            if (titleController.text.isEmpty ||
                                dateController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('يرجى ملء جميع الحقول')),
                              );
                              return;
                            }
                            final exam = ExamModel(
                              id: 0,
                              title: titleController.text,
                              description: descriptionController.text,
                              date: dateController.text,
                            );
                            context.read<ExamBloc>().add(
                                  CreateExam(circleId, exam),
                                );
                          },
                    child: state is ExamLoading
                        ? const CircularProgressIndicator()
                        : const Text('إنشاء'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
