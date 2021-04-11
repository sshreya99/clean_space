import 'package:auto_route/auto_route_annotations.dart';
import 'package:clean_space/ui/views/complaints/complaints_view.dart';
import 'package:clean_space/ui/views/home/feed_view.dart';
import 'package:clean_space/ui/views/home/home_screen.dart';
import 'package:clean_space/ui/views/posts/post_view.dart';
import 'package:clean_space/ui/views/startup/welcome_screen.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: WelcomeScreen),
  MaterialRoute(page: ComplaintsView, initial: true),
  MaterialRoute(page: PostView),
  MaterialRoute(page: FeedView),
  MaterialRoute(page: HomeScreen),
])
class $Router {}
