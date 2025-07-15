import 'package:flutter/material.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/features/auth/view/pages/signin_page.dart';

import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/route_const.dart';
import '../../../tasmi3/presentaition/view/tasmi3.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _navigateNext();
    },);
    super.initState();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(Duration(seconds: 2));
    String token = SharedPreferencesManger.instance.getString(SharedPreferencesKeys.token)??'';
     if (token.isNotEmpty) {
      AppNavigator.instance.push( name:RouteConst.home);
    }  else {
       AppNavigator.instance.push( name:RouteConst.login);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor :greenGray,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesManager.splashPage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
