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
    return BlocProvider(
      create: (context) => LessonBloc(sl())..add(FetchLesson()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 280,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagesManager.component),
                    fit: BoxFit.fill,
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildIcon(Icons.person),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                  SharedPreferencesManger.instance.getString(SharedPreferencesKeys.firstName)??'',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),

                                  ),
                                  SizedBox(width: 3,),
                                  Text(
                                   SharedPreferencesManger.instance.getString(SharedPreferencesKeys.lastName)??'',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Left side icons
                      Row(
                        children: [
                          _buildIcon(Icons.menu,onTap: (){
                            AppNavigator.instance.push(name: RouteConst.drawer);
                          }),
                          SizedBox(width: 10),
                          _buildIcon(Icons.emoji_events,onTap: (){
                            _openWebsite("https://teacherchallenges-40c16.web.app");
                          }),
                          // example for trophy/award icon
                        ],
                      ),
                      // Right side profile info
                    ],
                  ),
                ),
              ),

              BlocBuilder<LessonBloc, LessonState>(
                builder: (context, state) {
                  if (state.fetchLessonStatus == ControllerStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.fetchLessonStatus ==
                      ControllerStatus.error) {
                    return Center(child: Text(state.message));
                  } else if (state.fetchLessonStatus ==
                      ControllerStatus.loaded) {
                    return state.circles.isEmpty
                        ? Center(child: Text("لا يوجد حلقات لك هنا"))
                        : GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              childAspectRatio: 1.2,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: state.circles.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  AppNavigator.instance.push(
                                      name: RouteConst.session,
                                      extra: state.circles[index].id);
                                },
                                child: SizedBox(
                                  width: 100,
                                  height: 130,
                                  child: greenContainer(
                                    name: state.circles[index].name,
                                    onTap: () {
                                      showCircleDialog(
                                        context,
                                        state.circles[index].name,
                                        state.circles[index]
                                            .students, // List<String>
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: lightGreen1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.menu_book_outlined,
                            color: Colors.grey),
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
                    // Wrap ListView.builder with Expanded to constrain its height
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
      onTap: onTap, // هنا تمرير التابع
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
