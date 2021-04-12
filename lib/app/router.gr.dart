// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/area.dart';
import '../models/post.dart';
import '../models/user_profile.dart';
import '../ui/views/auth/forgot_password_send_verification_screen.dart';
import '../ui/views/auth/login_screen.dart';
import '../ui/views/auth/reset_new_password_screen.dart';
import '../ui/views/auth/signup_screen.dart';
import '../ui/views/home/feed_view.dart';
import '../ui/views/home/home_screen.dart';
import '../ui/views/posts/create_post_screen.dart';
import '../ui/views/posts/feed_single_screen.dart';
import '../ui/views/profile/edit_profile_view.dart';
import '../ui/views/profile/profile_screen.dart';
import '../ui/views/profile/settings_screen.dart';
import '../ui/views/rank/area_feed_view.dart';
import '../ui/views/rank/rank_view.dart';
import '../ui/views/startup/on_boarding_screen.dart';
import '../ui/views/startup/startup_screen.dart';

class Routes {
  static const String startupScreen = '/';
  static const String onBoardingScreen = '/on-boarding-screen';
  static const String loginScreen = '/login-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String forgotPasswordSendVerificationScreen =
      '/forgot-password-send-verification-screen';
  static const String resetNewPasswordScreen = '/reset-new-password-screen';
  static const String profileScreen = '/profile-screen';
  static const String editProfileView = '/edit-profile-view';
  static const String settingsScreen = '/settings-screen';
  static const String homeScreen = '/home-screen';
  static const String createPostScreen = '/create-post-screen';
  static const String feedView = '/feed-view';
  static const String feedSingleScreen = '/feed-single-screen';
  static const String rankView = '/rank-view';
  static const String areaFeedView = '/area-feed-view';
  static const all = <String>{
    startupScreen,
    onBoardingScreen,
    loginScreen,
    signUpScreen,
    forgotPasswordSendVerificationScreen,
    resetNewPasswordScreen,
    profileScreen,
    editProfileView,
    settingsScreen,
    homeScreen,
    createPostScreen,
    feedView,
    feedSingleScreen,
    rankView,
    areaFeedView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupScreen, page: StartupScreen),
    RouteDef(Routes.onBoardingScreen, page: OnBoardingScreen),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.signUpScreen, page: SignUpScreen),
    RouteDef(Routes.forgotPasswordSendVerificationScreen,
        page: ForgotPasswordSendVerificationScreen),
    RouteDef(Routes.resetNewPasswordScreen, page: ResetNewPasswordScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.editProfileView, page: EditProfileView),
    RouteDef(Routes.settingsScreen, page: SettingsScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.createPostScreen, page: CreatePostScreen),
    RouteDef(Routes.feedView, page: FeedView),
    RouteDef(Routes.feedSingleScreen, page: FeedSingleScreen),
    RouteDef(Routes.rankView, page: RankView),
    RouteDef(Routes.areaFeedView, page: AreaFeedView),
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
    LoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginScreen(),
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
      final args = data.getArgs<ProfileScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileScreen(
          userProfile: args.userProfile,
          isCurrentProfile: args.isCurrentProfile,
        ),
        settings: data,
      );
    },
    EditProfileView: (data) {
      final args = data.getArgs<EditProfileViewArguments>(
        orElse: () => EditProfileViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProfileView(userProfile: args.userProfile),
        settings: data,
      );
    },
    SettingsScreen: (data) {
      final args = data.getArgs<SettingsScreenArguments>(
        orElse: () => SettingsScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsScreen(userProfile: args.userProfile),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    CreatePostScreen: (data) {
      final args = data.getArgs<CreatePostScreenArguments>(
        orElse: () => CreatePostScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreatePostScreen(
          isComplaint: args.isComplaint,
          post: args.post,
        ),
        settings: data,
      );
    },
    FeedView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FeedView(),
        settings: data,
      );
    },
    FeedSingleScreen: (data) {
      final args = data.getArgs<FeedSingleScreenArguments>(
        orElse: () => FeedSingleScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => FeedSingleScreen(post: args.post),
        settings: data,
      );
    },
    RankView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RankView(),
        settings: data,
      );
    },
    AreaFeedView: (data) {
      final args = data.getArgs<AreaFeedViewArguments>(
        orElse: () => AreaFeedViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AreaFeedView(location: args.location),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProfileScreen arguments holder class
class ProfileScreenArguments {
  final UserProfile userProfile;
  final bool isCurrentProfile;
  ProfileScreenArguments(
      {@required this.userProfile, this.isCurrentProfile = false});
}

/// EditProfileView arguments holder class
class EditProfileViewArguments {
  final UserProfile userProfile;
  EditProfileViewArguments({this.userProfile});
}

/// SettingsScreen arguments holder class
class SettingsScreenArguments {
  final UserProfile userProfile;
  SettingsScreenArguments({this.userProfile});
}

/// CreatePostScreen arguments holder class
class CreatePostScreenArguments {
  final bool isComplaint;
  final Post post;
  CreatePostScreenArguments({this.isComplaint = false, this.post});
}

/// FeedSingleScreen arguments holder class
class FeedSingleScreenArguments {
  final Post post;
  FeedSingleScreenArguments({this.post});
}

/// AreaFeedView arguments holder class
class AreaFeedViewArguments {
  final Location location;
  AreaFeedViewArguments({this.location});
}
