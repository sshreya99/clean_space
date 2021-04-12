import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/ui/utils/setup_dialog_ui.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/auth/forgot_password_send_verification_screen.dart';
import 'package:clean_space/ui/views/auth/reset_new_password_screen.dart';
import 'package:clean_space/ui/views/posts/rank_test.dart';
import 'package:clean_space/ui/views/profile/profile_screen.dart';
import 'package:clean_space/ui/views/profile/settings_screen.dart';
import 'package:clean_space/ui/views/startup/on_boarding_screen.dart';
import 'package:clean_space/ui/views/startup/splash_screen.dart';
import 'package:clean_space/ui/views/startup/startup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/services.dart';
// import 'package:clean_space/Screens/Home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator(); // Dependency Injection
  setupDialogUi(); // Dialog setup
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        primaryColor: ThemeColors.primary,
          accentColor: ThemeColors.primary
      ),
      home: RankTest(),
      // initialRoute: Routes.startupScreen,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
