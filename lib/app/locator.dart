import 'package:clean_space/services/authentication_service.dart';
import 'package:clean_space/services/complaints_service.dart';
import 'package:clean_space/services/firestore_service.dart';
import 'package:clean_space/services/image_services.dart';
import 'package:clean_space/services/posts_service.dart';
import 'package:clean_space/services/user_profile_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => UserProfileService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => PostsService());
  locator.registerLazySingleton(() => ComplaintsService());
  locator.registerLazySingleton(() => ImageService());

  // Third Party Services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);

}
