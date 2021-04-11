import 'package:auto_route/auto_route_annotations.dart';
import 'package:clean_space/ui/views/complaints/complaints_view.dart';
import 'package:clean_space/ui/views/home/feed_view.dart';
import 'package:clean_space/ui/views/posts/post_view.dart';
import 'package:clean_space/ui/views/auth/forgot_password_send_verification_screen.dart';
import 'package:clean_space/ui/views/auth/reset_new_password_screen.dart';
import 'package:clean_space/ui/views/auth/login_screen.dart';
import 'package:clean_space/ui/views/auth/signup_screen.dart';
import 'package:clean_space/ui/views/home/home_screen.dart';
import 'package:clean_space/ui/views/profile/profile_screen.dart';
import 'package:clean_space/ui/views/profile/settings_screen.dart';
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
  MaterialRoute(page: SettingsScreen),

  MaterialRoute(page: HomeScreen),
  
    MaterialRoute(page: ComplaintsView),
  MaterialRoute(page: PostView),
  MaterialRoute(page: FeedView),
])
class $Router {}
