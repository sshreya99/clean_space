import 'package:clean_space/ui/routers/routes.dart';
import 'package:clean_space/ui/view/home/home.dart';
import 'package:clean_space/ui/view/startup_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startUp:
        return MaterialPageRoute(builder: (context) => StartupScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => StartupScreen());
    }
  }
}
