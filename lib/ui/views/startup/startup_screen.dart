import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/ui/views/startup/splash_screen.dart';
import 'package:flutter/material.dart';

class StartupScreen extends StatefulWidget {
  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  void initState() {
    super.initState();
    handleStartupLogic();
  }
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }

  void handleStartupLogic() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, Routes.onBoardingScreen);
  }
}
