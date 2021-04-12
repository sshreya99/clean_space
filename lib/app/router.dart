import 'package:auto_route/auto_route_annotations.dart';
import 'package:clean_space/ui/views/home/feed_view.dart';
import 'package:clean_space/ui/views/auth/forgot_password_send_verification_screen.dart';
import 'package:clean_space/ui/views/auth/reset_new_password_screen.dart';
import 'package:clean_space/ui/views/auth/login_screen.dart';
import 'package:clean_space/ui/views/auth/signup_screen.dart';
import 'package:clean_space/ui/views/home/home_screen.dart';
import 'package:clean_space/ui/views/posts/create_post_screen.dart';
import 'package:clean_space/ui/views/posts/feed_single_screen.dart';
import 'package:clean_space/ui/views/profile/edit_profile_view.dart';
import 'package:clean_space/ui/views/profile/profile_screen.dart';
import 'package:clean_space/ui/views/profile/settings_screen.dart';
import 'package:clean_space/ui/views/rank/area_feed_view.dart';
import 'package:clean_space/ui/views/rank/rank_view.dart';
import 'package:clean_space/ui/views/startup/on_boarding_screen.dart';
import 'package:clean_space/ui/views/startup/startup_screen.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: StartupScreen, initial: true),
  MaterialRoute(page: OnBoardingScreen),
  MaterialRoute(page: LoginScreen),
  MaterialRoute(page: SignUpScreen),
  MaterialRoute(page: ForgotPasswordSendVerificationScreen),
  MaterialRoute(page: ResetNewPasswordScreen),

  MaterialRoute(page: ProfileScreen),
  MaterialRoute(page: EditProfileView),
  MaterialRoute(page: SettingsScreen),

  MaterialRoute(page: HomeScreen),
  
    MaterialRoute(page: CreatePostScreen),
  MaterialRoute(page: FeedView),
  MaterialRoute(page: FeedSingleScreen),
  MaterialRoute(page: RankView),
  MaterialRoute(page: AreaFeedView),
])
class $Router {}
