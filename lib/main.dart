import 'package:clean_space/core/services/navigation_service.dart';
import 'package:clean_space/providers.dart';
import 'package:clean_space/ui/routers/route_manager.dart';
import 'package:clean_space/ui/utils/theme.dart';
import 'package:clean_space/ui/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        navigatorKey: locator<NavigationService>().navigationKey,
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: HomeScreen(),
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
