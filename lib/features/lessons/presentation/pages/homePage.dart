import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/resource/colors_manager.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/features/lessons/data/model/student_model.dart';
import 'package:teacher/features/lessons/presentation/bloc/lesson_bloc.dart';
import 'package:teacher/features/lessons/presentation/bloc/lesson_event.dart';
import 'package:teacher/features/lessons/presentation/bloc/lesson_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/config/sharedPreferences_manager.dart';
import '../../../../core/enums/controller_status.dart';
import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/services_locator.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/green_container.dart';
import '../widgets/cup_Container_widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  Future<void> _openWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("تعذر فتح الرابط: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LessonBloc(sl())..add(FetchLesson()),
      child: Scaffold(
         extendBodyBehindAppBar: true, // يجعل الـ body تمتد خلف AppBar
        appBar: AppBar(
  backgroundColor: Colors.transparent, // الشفافية الكاملة
  elevation: 0, // إزالة الظل الافتراضي
  shadowColor: Colors.transparent, // إزالة أي ظل افتراضي
  leading: SizedBox(), // إذا أردت إخفاء أي أيقونات قياسية
  actions: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildIcon(Icons.menu, onTap: () {
        AppNavigator.instance.push(name: RouteConst.drawer);
      }),
    ),
   
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildIcon(Icons.emoji_events, onTap: () {
        _openWebsite("https://teacherchallenges-40c16.web.app");
      }),
    ),
  ],
),

        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header container with fixed height — Row is direct child
              Container(
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagesManager.component),
                    fit: BoxFit.fill,
                  ),
                ),
                width: double.infinity,
                child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: Row(
        children: [
          _buildIcon(Icons.person),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '${SharedPreferencesManger.instance.getString(SharedPreferencesKeys.firstName) ?? ''} '
              '${SharedPreferencesManger.instance.getString(SharedPreferencesKeys.lastName) ?? ''}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),

                    
                    // Row(
                    //   children: [
                     
                    //   ],
                    // ),
                  ],
                ),
              ),

              // BlocBuilder and GridView (kept as requested; children wrapped to have bounded size)
              BlocBuilder<LessonBloc, LessonState>(
                builder: (context, state) {
                  if (state.fetchLessonStatus == ControllerStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.fetchLessonStatus == ControllerStatus.error) {
                    return Center(child: Text(state.message));
                  } else if (state.fetchLessonStatus == ControllerStatus.loaded) {
                    return state.circles.isEmpty
                        ? Center(child: Text("لا يوجد حلقات لك هنا"))
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1 / 1,
                            ),
                            itemCount: state.circles.length,
                            itemBuilder: (context, index) {
                              // Wrap the greenContainer with a bounded box to ensure InkWell / pointer listeners have constraints
                              return InkWell(
                                onTap: () {
                                  AppNavigator.instance.push(
                                    name: RouteConst.session,
                                    extra: state.circles[index].id,
                                  );
                                },
                                child: SizedBox.expand(
                                  child: greenContainer(
                                    name: state.circles[index].name,
                                    onTap: () {
                                      showCircleDialog(
                                        context,
                                        state.circles[index].name,
                                        state.circles[index].students,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCircleDialog(
      BuildContext context, String circleName, List<StudentModel> students) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: 480,
              width: 330,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: lightGreen1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.menu_book_outlined, color: Colors.grey),
                        const SizedBox(width: 14),
                        Text(
                          circleName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "أسماء الطلاب",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 17),
                          decoration: BoxDecoration(
                            color: lightGreen1,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.person, color: gray),
                              const SizedBox(width: 15),
                              Text(
                                '${student.firstName} ${student.lastName}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.grey[700]),
      ),
    );
  }
}
