import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacher/core/core_page.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/features/StudenTtasmi3/presentation/tasmi3Student.dart';
import 'package:teacher/features/Student_history/presentation/view/Student_history_ui.dart';
import 'package:teacher/features/auth/view/pages/signin_page.dart';
import 'package:teacher/features/exam/data/model/exam_model.dart';
import 'package:teacher/features/exam/presentation/pages/circle_exam_page.dart';
import 'package:teacher/features/exam/presentation/pages/exam_page.dart';
import 'package:teacher/features/exam/presentation/pages/mark_page.dart';
import 'package:teacher/features/getbookhadith/presentation/view/hdithui.dart';
import 'package:teacher/features/input_talqeen/input_talqeen.dart';
import 'package:teacher/features/session_lesson/view/pages/session_page.dart';
import 'package:teacher/features/create_tasmi3_siession/presentation/view/Tasmi3_session_ui.dart';
import 'package:teacher/features/showstudent/presentation/view/showStudent.dart';
import 'package:teacher/features/tasmi3/presentation/view/tasmi3.dart';
import 'package:teacher/features/exam/presentation/pages/exam_page.dart';
import '../../features/attendance/presentation/page/attendance_page.dart';
import '../../features/drawer/drawer_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/splash/view/pages/splash_page.dart';

class AppRoutes {
  static AppRoutes? _instance;

  AppRoutes._();

  static AppRoutes get instance {
    _instance ??= AppRoutes._();
    return _instance!;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteConst.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteConst.login:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteConst.attendance:
        return MaterialPageRoute(
            builder: (_) => AttendancePage(
                  sessionId: args as int,
                ));
      case RouteConst.home:
        return MaterialPageRoute(builder: (_) => tasmi3UI());
      case RouteConst.drawer:
        return MaterialPageRoute(builder: (_) => DrawerPage());
      case RouteConst.circleExam:
        return MaterialPageRoute(builder: (_) => CircleExamPage());
      case RouteConst.profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case RouteConst.exam:
        return MaterialPageRoute(
            builder: (_) => ExamPage(circleId: args as int));
      case RouteConst.marks:
        return MaterialPageRoute(
            builder: (_) => MarkPage(
                  examModel: args as ExamModel,
                ));
      case RouteConst.session:
        return MaterialPageRoute(
            builder: (_) => SessionPage(
                  circleId: args as int,
                ));
      case RouteConst.CoreUi:
        return MaterialPageRoute(builder: (_) => CoreUi());

        // case RouteConst.Tasmi3SessionUi:
        //   return MaterialPageRoute(
        //       builder: (_) => Tasmi3SessionUi(
        //             id: args as int,
        //           ));
        return MaterialPageRoute(builder: (_) => tasmi3UI());
      case RouteConst.CoreUi:
        return MaterialPageRoute(builder: (_) => CoreUi());
      case RouteConst.Tasmi3SessionUi:
        final args = settings.arguments as List;

        return MaterialPageRoute(
            builder: (_) => Tasmi3SessionUi(
                circle_id: args[0] as int,
                CircleName: args[1],
                CircleType: args[2]));

        return MaterialPageRoute(builder: (_) => tasmi3UI());

      case RouteConst.CoreUi:
        return MaterialPageRoute(builder: (_) => CoreUi());

      case RouteConst.ShowStudentUi:
        final args = settings.arguments as List;
        final circlid = args[0];
        final circleType = args[1];
        final sessionid = args[2];
        return MaterialPageRoute(
            builder: (_) => ShowStudentUi(
                  circleId: circlid,
                  circleType: circleType,
                  sessionid: sessionid,
                ));

      case RouteConst.Tasmi3StudentInputUi:
        final args = settings.arguments as List;
        final sessionid = args[0];
        final studentid = args[1];
        final num circleId = args[2];
        final String circleType = args[3];

        return MaterialPageRoute(
            builder: (_) => Tasmi3StudentInputUi(
                  sessionid: sessionid,
                  studentid: studentid,
                  circleId: circleId,
                  circleType: circleType,
                ));

      case RouteConst.StudentHistoryUi:
        final args = settings.arguments as List;
        return MaterialPageRoute(
          builder: (_) => StudentHistoryUi(
            studentid: args[0],
            type: args[1],
            sessionid: args[2],
            circl_id: args[3],
          ),
        );

      case RouteConst.talqeeentInputUi:
        final args = settings.arguments as List;
        final sessionid = args[0];
        final studentid = args[1];
        return MaterialPageRoute(
            builder: (_) => talqeeentInputUi(
                  sessionid: sessionid,
                  studentid: studentid,
                ));
      case RouteConst.HadithScreen:
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => HadithScreen(
                  sessionid: args[0],
                  studentid: args[1],
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return const Scaffold(
          body: Center(child: Text('Error: Unknown Route')),
        );
      },
    );
  }
}

class NoInternetPage extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetPage({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                "No Internet Connection",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please check your connection and try again.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF201D54),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Retry",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
