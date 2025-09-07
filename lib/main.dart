import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/core_page.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/core/resource/services_locator.dart';
import 'package:teacher/features/create_tasmi3_siession/presentation/view/Tasmi3_session_ui.dart';
import 'package:teacher/features/splash/view/pages/splash_page.dart';
import 'package:teacher/features/tasmi3/presentation/view/tasmi3.dart';

mixin AppLocale {
  static const String title = 'title';
  static const Map<String, dynamic> Ar = {title: 'Localization'};
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManger.instance.initSharedPreferences();
  await FlutterLocalization.instance.ensureInitialized();
  ServicesLocator().init();
  await SharedPreferencesManger.instance.remove(SharedPreferencesKeys.token);
  runApp(const MyApp());
}

final FlutterLocalization _localization = FlutterLocalization.instance;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale('ar', AppLocale.Ar),
      ],
      initLanguageCode: 'ar',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteConst.splash,
        navigatorKey: AppNavigator.instance.navigationKey,
        onGenerateRoute: AppRoutes.generateRoute,
        supportedLocales: _localization.supportedLocales,
        localizationsDelegates: _localization.localizationsDelegates,
      ),
    );
  }
}