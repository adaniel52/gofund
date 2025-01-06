import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._privateConstructor();

  static NavigationService? _instance;

  static NavigationService get instance {
    _instance ??= NavigationService._privateConstructor();
    return _instance!;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> navigateTo(Widget screen) async {
    await navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
