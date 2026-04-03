import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static Future<dynamic>? pushNamed(String routeName) {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }
  static Future pushReplacementNamed(String routeName) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName);
  }

  static Future pushNamedAndRemoveUntil(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}