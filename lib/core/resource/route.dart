import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacher/core/core_page.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/features/auth/view/pages/signin_page.dart';
import 'package:teacher/features/tasmi3/presentation/view/tasmi3.dart';

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
      case RouteConst.home:
        return MaterialPageRoute(builder: (_) => const tasmi3UI());
        case RouteConst.CoreUi:
        return MaterialPageRoute(builder: (_)=>  CoreUi());
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
