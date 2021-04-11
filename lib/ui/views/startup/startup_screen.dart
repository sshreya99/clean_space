import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/ui/views/startup/splash_screen.dart';
import 'package:clean_space/utils/helper.dart';
import 'package:flutter/material.dart';

class StartupScreen extends StatefulWidget {
  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
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
    bool isFirstTimeUserBool = await isFirstTimeUser();

    if(isFirstTimeUserBool){
      await markAsNotFirstTimeUser();
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, Routes.onBoardingScreen);
      return;
    }

    bool isUserLoggedIn = _authenticationService.isUserLoggedIn;
    if (isUserLoggedIn){
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
      return;
    }

    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, Routes.loginScreen);
  }
}
