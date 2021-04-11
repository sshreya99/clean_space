// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/complaints/complaints_view.dart';
import '../ui/views/home/feed_view.dart';
import '../ui/views/home/home_screen.dart';
import '../ui/views/posts/post_view.dart';
import '../ui/views/startup/welcome_screen.dart';

class Routes {
  static const String welcomeScreen = '/welcome-screen';
  static const String complaintsView = '/';
  static const String postView = '/post-view';
  static const String feedView = '/feed-view';
  static const String homeScreen = '/home-screen';
  static const all = <String>{
    welcomeScreen,
    complaintsView,
    postView,
    feedView,
    homeScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.welcomeScreen, page: WelcomeScreen),
    RouteDef(Routes.complaintsView, page: ComplaintsView),
    RouteDef(Routes.postView, page: PostView),
    RouteDef(Routes.feedView, page: FeedView),
    RouteDef(Routes.homeScreen, page: HomeScreen),
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
    ComplaintsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ComplaintsView(),
        settings: data,
      );
    },
    PostView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PostView(),
        settings: data,
      );
    },
    FeedView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FeedView(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
  };
}
