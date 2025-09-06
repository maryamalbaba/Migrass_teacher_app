// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/icon_image_manager.dart';
import 'package:teacher/core/widgets/custom_date_container.dart';
import 'package:teacher/core/widgets/custom_history_container.dart';
import 'package:teacher/features/Student_history/data/models/hadith_tasmi3.dart';
import 'package:teacher/features/Student_history/data/models/quran_tasimi3_history.dart';
import 'package:teacher/features/Student_history/data/repo/repo_Imp.dart';
import 'package:teacher/features/Student_history/data/source/remote/imp_remote.dart';
import 'package:teacher/features/Student_history/domain/enum/type_tasmi3enum.dart';
import 'package:teacher/features/Student_history/domain/repo/repo.dart';
import 'package:teacher/features/Student_history/domain/usecase/student_tasmi3_history.dart';
import 'package:teacher/features/Student_history/presentation/view/bloc/tasmi3_history_bloc.dart';
class StudentHistoryUi extends StatelessWidget {
  const StudentHistoryUi({
    super.key,
    required this.studentid,
    required this.type,
  });

  final String studentid;
  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Tasmi3HistoryBloc(
      GetStudentHistory(HistoryTasmi3RepoImp(remotdata:StudentHistoryRemoteDataSourceImpl() )))
      ..add(
          GetTasmi3History(
            studentId: studentid,
            type: _mapType(type),
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("الأربعاء", style: TextStyle(fontSize: 15)),
              SizedBox(width: 8),
              Text("3 أيار", style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        body: BlocBuilder<Tasmi3HistoryBloc, Tasmi3HistoryState>(
          builder: (context, state) {
            if (state is loadingHistoryState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ErrorTasmi3History) {
              return Center(child: Text(state.message));
            }

            if (state is SuccestTasmi3History) {
              final items = state.items;

              if (items.isEmpty) {
                return const Center(child: Text("لا يوجد سجلات"));
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Image.asset(ImagesManager.addDotted),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = items[index];

                        if (item is QuranTasimi3History) {
                          return Row(
                            children: [
                              CustomDateContainer(
                                date: item.date,
                                day: item.day,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomHistoryContainer(
                                  atendance: item.attendance,
                                  fromSurahName: item.fromSurahName,
                                  fromAyah: item.fromAyah,
                                  toSurahName: item.toSurahName,
                                  toAyah: item.toAyah,
                                ),
                              ),
                            ],
                          );
                        }

                        if (item is HadithHistoryTasmi3) {
                          return Row(
                            children: [
                              CustomDateContainer(
                                date: item.date,
                                day: item.day,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomHadithHistoryContainer(
                                  attendance: item.attendance,
                                  bookName: item.bookName,
                                  pageNumber: item.pageNamber,
                                ),
                              ),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      },
                      childCount: items.length,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink(); // initial state
          },
        ),
      ),
    );
  }
}






HalaqaType _mapType(String type) {
  switch (type) {
    case "قرآن":
      return HalaqaType.quran;
    case "حديث":
      return HalaqaType.hadith;
    case "تلقين":
      return HalaqaType.quran;
    default:
      return HalaqaType.quran; // default
  }
}






class CustomHadithHistoryContainer extends StatelessWidget {
  const CustomHadithHistoryContainer({
    super.key,
    required this.attendance,
    required this.bookName,
    required this.pageNumber,
  });

  final bool attendance;
  final String bookName;
  final num pageNumber;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          Container(
            width: 250.w,
            height: 150.h,
            decoration: BoxDecoration(
              color: mintGreen2,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// حضور
                  Row(
                    children: [
                      Image.asset(
                        IconImageManager.star,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 6),
                      Text("حضور: ${attendance ? "نعم" : "لا"}"),
                    ],
                  ),
                  const SizedBox(height: 8),

                  /// عنوان
                  Row(
                    children: [
                      Image.asset(
                        IconImageManager.star,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 6),
                      const Text("تسميع حديث:"),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// تفاصيل الحديث
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("من كتاب: "),
                            Text(bookName),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("رقم الصفحة: "),
                            Text("$pageNumber"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// زخرفة
          Positioned(
            bottom: 0,
            left: -5.5,
            child: Image.asset(
              ImagesManager.threecircle,
              height: 30,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDateContainer extends StatelessWidget {
  const CustomDateContainer({
    super.key,
    required this.date,
    required this.day,
  });

  final String date;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: mintGreen2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            date,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}