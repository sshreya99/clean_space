// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/auth/forgot_password_send_verification_screen.dart';
import '../ui/views/auth/reset_new_password_screen.dart';
import '../ui/views/auth/signin_screen.dart';
import '../ui/views/auth/signup_screen.dart';
import '../ui/views/home/home_screen.dart';
import '../ui/views/profile/profile_screen.dart';
import '../ui/views/profile/settings_screen.dart';
import '../ui/views/startup/on_boarding_screen.dart';
import '../ui/views/startup/startup_screen.dart';

class Routes {
  static const String startupScreen = '/';
  static const String onBoardingScreen = '/on-boarding-screen';
  static const String signinScreen = '/signin-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String forgotPasswordSendVerificationScreen =
      '/forgot-password-send-verification-screen';
  static const String resetNewPasswordScreen = '/reset-new-password-screen';
  static const String profileScreen = '/profile-screen';
  static const String settingsScreen = '/settings-screen';
  static const String homeScreen = '/home-screen';
  static const all = <String>{
    startupScreen,
    onBoardingScreen,
    signinScreen,
    signUpScreen,
    forgotPasswordSendVerificationScreen,
    resetNewPasswordScreen,
    profileScreen,
    settingsScreen,
    homeScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupScreen, page: StartupScreen),
    RouteDef(Routes.onBoardingScreen, page: OnBoardingScreen),
    RouteDef(Routes.signinScreen, page: SigninScreen),
    RouteDef(Routes.signUpScreen, page: SignUpScreen),
    RouteDef(Routes.forgotPasswordSendVerificationScreen,
        page: ForgotPasswordSendVerificationScreen),
    RouteDef(Routes.resetNewPasswordScreen, page: ResetNewPasswordScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.settingsScreen, page: SettingsScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupScreen(),
        settings: data,
      );
    },
    OnBoardingScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingScreen(),
        settings: data,
      );
    },
    SigninScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SigninScreen(),
        settings: data,
      );
    },
    SignUpScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpScreen(),
        settings: data,
      );
    },
    ForgotPasswordSendVerificationScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgotPasswordSendVerificationScreen(),
        settings: data,
      );
    },
    ResetNewPasswordScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ResetNewPasswordScreen(),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileScreen(),
        settings: data,
      );
    },
    SettingsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsScreen(),
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
