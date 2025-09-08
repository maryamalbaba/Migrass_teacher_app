import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/core/widgets/appbar.dart';
import 'package:teacher/features/lessons/presentation/bloc/lesson_bloc.dart';
import 'package:teacher/features/lessons/presentation/bloc/lesson_event.dart';
import 'package:teacher/features/lessons/presentation/bloc/lesson_state.dart';

import '../../../../core/enums/controller_status.dart';
import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/navigator_manager.dart';
import '../../../../core/resource/route_const.dart';
import '../../../../core/resource/services_locator.dart';
import '../../../../core/widgets/custom_appbar.dart';

class CircleExamPage extends StatelessWidget {
  const CircleExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonBloc(sl())..add(FetchLesson()),
      child: Scaffold(
        appBar:               SoftAppBar(title: 'المواد ', ),

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 80),
              Expanded(
                child: BlocBuilder<LessonBloc, LessonState>(
                  builder: (context, state) {
                    if (state.fetchLessonStatus == ControllerStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.fetchLessonStatus ==
                        ControllerStatus.error) {
                      return Center(child: Text(state.message));
                    } else if (state.fetchLessonStatus ==
                        ControllerStatus.loaded) {
                      if (state.circles.isEmpty) {
                        // عرض رسالة عندما تكون القائمة فارغة
                        return const Center(
                          child: Text(
                            'لا توجد حلقات متاحة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.circles.length,
                        itemBuilder: (context, index) {
                          final circle = state.circles[index];
                          return Center(
                            child: Card(
                              name: circle.name,
                              onTap: () {
                                AppNavigator.instance.push(
                                    name: RouteConst.exam,extra: circle.id
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const Card({
    Key? key,
    required this.name,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        height: 47,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: mintGreen2,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}