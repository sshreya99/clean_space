import 'package:clean_space/core/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //! External


  // Services
  locator.registerLazySingleton(() => NavigationService());

  // ViewModels

}