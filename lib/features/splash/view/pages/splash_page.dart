import 'package:flutter/material.dart';
import 'package:teacher/core/config/sharedPreferences_manager.dart';
import 'package:teacher/core/enums/shared_preferences_keys.dart';
import 'package:teacher/core/resource/assets_manager.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/features/auth/view/pages/signin_page.dart';

import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/route_const.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _topCloudController;
  late AnimationController _bottomCloudController;
  late Animation<Offset> _topCloudAnimation;
  late Animation<Offset> _bottomCloudAnimation;

  @override
  void initState() {
    super.initState();

    _topCloudController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2050),
    );

    _bottomCloudController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2050),
    );

    _topCloudAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _topCloudController,
      curve: Curves.easeOut,
    ));

    _bottomCloudAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bottomCloudController,
      curve: Curves.easeOut,
    ));

    _topCloudController.forward();
    _bottomCloudController.forward();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _navigateNext();
    });
  }

  Future<void> _navigateNext() async {
    await Future.delayed(Duration(seconds: 6));
    String token = SharedPreferencesManger.instance.getString(SharedPreferencesKeys.token) ?? '';
    if (token.isNotEmpty) {
      AppNavigator.instance.push(
        name: RouteConst.CoreUi
     // name: RouteConst.HadithScreen
      );
    } else {
      AppNavigator.instance.push(name: RouteConst.login);
    }
  }

  @override
  void dispose() {
    _topCloudController.dispose();
    _bottomCloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: SlideTransition(
              position: _topCloudAnimation,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImagesManager.upsideDownCloud),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Image.asset(
                ImagesManager.logoWithsentance,
                width: MediaQuery.of(context).size.width * 0.75,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SlideTransition(
              position: _bottomCloudAnimation,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImagesManager.downCloude),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
