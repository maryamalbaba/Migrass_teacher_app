import 'package:flutter/material.dart';
import 'package:teacher/core/resource/route.dart';




class AppNavigator {
  static AppNavigator? _instance;

  AppNavigator._();

  BuildContext get context => navigationKey!.currentContext!;

  GlobalKey<NavigatorState>?  navigationKey = GlobalKey<NavigatorState>();

  static AppNavigator get instance {
    _instance ??= AppNavigator._();
    return _instance!;
  }




  void _navigateToNoInternetPage({
    required String routeName,
    dynamic extra,
  }) {
    navigationKey?.currentState!.push(
      MaterialPageRoute(
        builder: (_) => NoInternetPage(
          onRetry: ()  {
            // final isConnected =  NetworkStatus.instance.isConnected;
            final isConnected = true;
            if (isConnected) {
              navigationKey?.currentState!.pop();
              push(name: routeName, extra: extra);
            }
          },
        ),
      ),
    );
  }

  Future<void> push({
    required String name,
    dynamic extra,
  }) async {
    // final isConnected =  NetworkStatus.instance.isConnected;
    final isConnected = true;
    if (isConnected) {
      navigationKey?.currentState!.pushNamed(name, arguments: extra);
    } else {
      _navigateToNoInternetPage(routeName: name, extra: extra);
    }
  }

  Future<void> pushReplacement({
    required String name,
    dynamic extra,
  }) async {
    // final isConnected =  NetworkStatus.instance.isConnected;
    final isConnected = true;

    if (isConnected) {
      navigationKey?.currentState!.pushReplacementNamed(name, arguments: extra);
    } else {
      _navigateToNoInternetPage(routeName: name, extra: extra);
    }
  }

  Future<void> pushReplacementAll({
    required String name,
    dynamic extra,
  }) async {
    // final isConnected =  NetworkStatus.instance.isConnected;
    final isConnected = true;

    if (isConnected) {
      navigationKey?.currentState!.pushNamedAndRemoveUntil(
        name,
            (Route<dynamic> route) => false,
        arguments: extra,
      );
    } else {
      _navigateToNoInternetPage(routeName: name, extra: extra);
    }
  }

  void pop() {
    navigationKey?.currentState!.pop();
  }
}
