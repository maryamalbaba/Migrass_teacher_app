import 'package:flutter/material.dart';
import 'package:teacher/features/tasmi3/presentaition/view/tasmi3.dart';

import 'core/config/sharedPreferences_manager.dart';
import 'core/resource/navigator_manager.dart';
import 'core/resource/route.dart';
import 'core/resource/route_const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManger.instance.initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteConst.splash,
      navigatorKey: AppNavigator.instance.navigationKey,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
