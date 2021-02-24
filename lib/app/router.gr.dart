// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/startup/welcome_screen.dart';

class Routes {
  static const String welcomeScreen = '/';
  static const all = <String>{
    welcomeScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.welcomeScreen, page: WelcomeScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    WelcomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => WelcomeScreen(),
        settings: data,
      );
    },
  };
}
