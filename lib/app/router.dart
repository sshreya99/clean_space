import 'package:auto_route/auto_route_annotations.dart';
import 'package:clean_space/ui/views/startup/welcome_screen.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: WelcomeScreen, initial: true),
])
class $Router {}
