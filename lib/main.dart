import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/ui/utils/setup_dialog_ui.dart';
import 'package:clean_space/Screens/Home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:stacked_services/stacked_services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator(); // Dependency Injection
  setupDialogUi(); // Dilog setup
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.welcomeScreen,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
